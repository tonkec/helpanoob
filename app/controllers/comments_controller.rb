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


  def edit
  end

  def update 
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comments_params)
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: post_path(@post) }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def load_parent
      @post = Post.find(params[:post_id])
    end

    def comments_params
      params.require(:comment).permit(:content)
    end
end