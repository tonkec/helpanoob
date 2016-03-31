# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :text
#  user_id    :integer
#

class CommentsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

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

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end


  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update 
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.update_attributes(comments_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def upvote
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.liked_by current_user
    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  def downvote
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.unliked_by current_user
     respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  private
    def comments_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @right_comment = Comment.find(params[:id])
      @user_id = @right_comment.user_id
      redirect_to root_path unless current_user.id == @right_comment.user_id
    end
end
