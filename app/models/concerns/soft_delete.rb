module SoftDelete
  extend ActiveSupport::Concern

  included do
    default_scope -> { where(deleted_at: nil) }

    alias_method :destroy!, :destroy
  end

  def destroy
    run_callbacks(:destroy) do
      update_attributes(deleted_at: Time.now.utc, updated_at: Time.now.utc) if persisted?

      @destroyed = true
    end
    freeze
  end

  def deleted?
    deleted_at.present?
  end
end
