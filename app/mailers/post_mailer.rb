class PostMailer < ApplicationMailer

  def new_post_email(user_id, post)
    attachments.inline['logo.png'] = File.read('public/images/logo.png')
    attachments.inline['twitter.png'] = File.read('public/images/twitter.png')
    attachments.inline['facebook.png'] = File.read('public/images/facebook.png')
    @user = User.find_by_id(user_id)
    @post = post

    mail(to: @user.email, subject: 'New question has been asked!')
  end
end
