class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true unless @notification.is_read?
    redirect_to post_path @notification.post
  end

  def index
    @notifications = current_user.notifications.order("created_at desc")
  end

  def unread
    last_id_in_dropdown = params[:lastID]

    if last_id_in_dropdown.nil?
      @unread_notifications = current_user.notifications.unread.last(3)
    else
      @unread_notifications = current_user.notifications.unread.where("id > ?", last_id_in_dropdown).limit(3)
    end

    @unread_notifications_count = current_user.notifications.unread.count
  end
end
