class UserMailer < Devise::Mailer  
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  #attachments.inline['logo.png'] = File.read('public/images/logo.png')
  #attachments.inline['twitter.png'] = File.read('public/images/twitter.png')
  #attachments.inline['facebook.png'] = File.read('public/images/facebook.png')
end