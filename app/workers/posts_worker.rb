class PostsWorker
 include Sidekiq::Worker

  def perform(user_id)
    puts user_id + "asdsad"
    puts "I am worker!"
    PostMailer.new_post_email(user_id)
  end
end