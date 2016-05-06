class PostMailer < ApplicationMailer

  def new_post_email(user_id)
    puts "MAILER!!"
    @user = User.find_by_id(user_id)
    mail(to: @user.email, subject: 'New question has been asked!')
  end
end
