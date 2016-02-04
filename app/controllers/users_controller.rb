class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user)
    @posts = @user.posts.paginate(page: params[:page])
  end
   
end