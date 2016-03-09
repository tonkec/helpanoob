class UsersController < ApplicationController
#  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def profile
    @user_posts_count = current_user.posts.count
    @user_comments_count = current_user.comments.count
    @user_posts = current_user.posts.page(params[:page]).per(5)
    @user_comments = current_user.comments.limit(5).reorder('created_at desc')
  end

  def show
    @user = User.find(params[:id]) 
  end

  def edit
    @user = User.find(params[:id]) 
  end

  def update 
    if current_user.update_attributes(user_params)
      flash[:success] = "Saved!"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:nickname, :email, :last_name, :first_name, :avatar)
    end  
end