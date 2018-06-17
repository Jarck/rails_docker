class AddTimestampsToUsersRoles < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:users_roles, default: Time.current)
  end
end
