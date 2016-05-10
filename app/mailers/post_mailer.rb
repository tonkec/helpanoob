class PostMailer < ApplicationMailer

  def new_post_email(user_id, post)
    @user = User.find_by_id(user_id)
    @post = post
    mail(to: @user.email, subject: 'New question has been asked!')
  end
end
