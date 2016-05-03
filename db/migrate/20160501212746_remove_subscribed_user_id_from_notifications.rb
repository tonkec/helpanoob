class RemoveSubscribedUserIdFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :subscribed_user_id, :integer
  end
end
