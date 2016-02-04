class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @post = current_user.posts.build if user_signed_in?
    
  end
   
end