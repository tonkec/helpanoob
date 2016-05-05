class PostMailer < ApplicationMailer

  def new_post_email(user, post, url)
    @user = user
    @post = post
    @url = url
    mail(to: @user.email, subject: 'New question has been asked!')
  end
end
