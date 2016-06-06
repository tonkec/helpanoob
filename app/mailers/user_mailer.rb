class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  include MailerHelper
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  before_filter :add_inline_attachments!

end