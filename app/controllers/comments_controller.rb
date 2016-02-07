class CommentsController < ApplicationController
  def new 
     @post = Post.find(params[:post_id])
     @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def index
    @comments = Comment.all
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
    def load_parent
      @post = Post.find(params[:post_id])
    end

    def comments_params
      params.require(:comment).permit(:content)
    end
end