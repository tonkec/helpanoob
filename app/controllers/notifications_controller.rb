class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true unless @notification.is_read?
    redirect_to post_path @notification.post
  end

  def index
    @notifications = current_user.notifications.order("created_at desc")
  end
end
