class PostsWorker
 include Sidekiq::Worker
 sidekiq_options :retry => false

  def perform(user_id)
    user = User.find_by_id(user_id)
    post = Post.first
    puts user
    puts post
    PostMailer.new_post_email(user_id, post).deliver
  end
end