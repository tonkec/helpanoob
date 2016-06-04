class CommentMailer < ApplicationMailer

  def new_answer_is_made(post_user_id, answer_id)
    attachments.inline['logo.png'] = File.read('public/images/logo.png')
    attachments.inline['twitter.png'] = File.read('public/images/twitter.png')
    attachments.inline['facebook.png'] = File.read('public/images/facebook.png')
    @answer = Comment.find answer_id
    @answer_user = @answer.user
    @post_user = User.find post_user_id

    mail(to: @post_user.email, subject: 'Someone answered your question!')
  end

end