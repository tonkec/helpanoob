class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user_posts = current_user.posts.paginate(page: params[:page])
  end
   
end