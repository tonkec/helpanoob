class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversations_path
    subject = "subject"
    body = "body"
    
    Mailboxer::Notification.notify_all(recipients,
    subject, 
    body,
    obj = conversation,
    sanitize_text = true,
    notification_code = nil, 
      send_mail = true)
    #User.first.notify("Hi", "What is up")

    #recipients.each do |recipient|
     # recipient.notify("You got new message",
      # "Let s pretend here is message body")
    #end
  end
end
