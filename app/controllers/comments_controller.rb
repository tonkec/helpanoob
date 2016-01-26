class CommentsController < ApplicationController
  def show
    @posts = current_user.posts
  end

  def index
    @comments = Comment.all
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
  end

  private
    def load_parent
      @post = Post.find(params[:post_id])
   end
end