module API
  module V1

    module Helpers

      def render(result, options = {})
        if result.is_a?(ActiveRecord::Relation)
          super(result.to_a, options)
        else
          super(result, options)
        end
      end

      # user helpers
      def current_user
        @current_user ||= User.find_by_id(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end

      def current_ability
        @current_ability ||= Ability.new(current_user)
      end

      def can?(*args)
        current_ability.can?(*args)
      end

      def authenticate!
        error!({ result: false, error: '401 Unauthorized' }, 401) unless current_user
      end

      def owner?(obj)
        return false if current_user.blank?
        return false if obj.blank?
        return true if admin?

        if obj.is_a?(User)
          return obj.id == current_user.id
        else
          return obj.user_id == current_user.id
        end
      end

      def admin?
        return false if current_user.blank?
        current_user.has_role?(:admin)
      end

      def error_404!
        error!({ result: false, error: 'Page not found' }, 404)
      end

      private

      def doorkeeper_token
        @_doorkeeper_token ||= Doorkeeper::OAuth::Token.authenticate(
          decorated_request,
          *Doorkeeper.configuration.access_token_methods
        )
      end

      def decorated_request
        Doorkeeper::Grape::AuthorizationDecorator.new(request)
      end

    end

  end
end
