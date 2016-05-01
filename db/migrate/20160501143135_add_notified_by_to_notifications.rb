class AddNotifiedByToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :notified_by, index: true, foreign_key: true
  end
end
