# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview
  def new_post_email
    PostMailer.new_post_email(User.first.id, Post.first)
  end
end
