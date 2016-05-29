class NewAnswerWorker
 include Sidekiq::Worker

  def perform(post_user_id, answer_id)
    CommentMailer.new_answer_is_made(post_user_id, answer_id).deliver
  end
end