class ApplicationMailer < ActionMailer::Base
  default from: "noreply-helpanoob@helpanoob.com"
  layout 'mailer'
  include MailerHelper


  before_filter :add_inline_attachments!

end
