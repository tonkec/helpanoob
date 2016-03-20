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
  before_action :correct_user, only: [:edit]
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
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update 
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.update_attributes(comments_params)
        format.html { redirect_to(@comment, :notice => 'comment was successfully updated.') }
        format.json { respond_with_bip(@comment) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@comment) }
      end
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
