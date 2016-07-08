class PostsWorker
 include Sidekiq::Worker

  def perform(user_id, post_id)
    user = User.find_by_id(user_id)
    post = Post.find post_id
    PostMailer.new_post_email(user_id, post).deliver
  end
end