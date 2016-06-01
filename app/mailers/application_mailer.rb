class ApplicationMailer < ActionMailer::Base
  default from: "noreply-helpanoob@helpanoob.com"
  layout 'mailer'

  attachments.inline['logo.png'] = File.read('public/images/logo.png')
  attachments.inline['twitter.png'] = File.read('public/images/twitter.png')
  attachments.inline['facebook.png'] = File.read('public/images/facebook.png')
end
