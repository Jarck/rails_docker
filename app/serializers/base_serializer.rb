class BaseSerializer < ActiveModel::Serializer
  delegate :current_user, to: :scope, allow_nil: true

  def cache(keys = [])
    Rails.cache.fetch(['serializer', *keys]) do
      yield
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def can?(*args)
    current_ability.can?(*args)
  end

  def abilities
    { update: can?(:update, object), destroy: can?(:destroy, object) }
  end
end