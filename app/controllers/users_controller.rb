# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string
#  introduction           :text
#  first_name             :string
#  last_name              :string
#  username               :string
#

class UsersController < ApplicationController
  before_action :authenticate_user!
  
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
    @user_posts = @user.posts
    @user_comments = @user.comments
  end

  def edit
    @user = User.find(params[:id]) 
  end

  def update 
    if current_user.update_attributes(user_params)
      flash[:success] = "Your profile has been successfully updated!"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :last_name, :first_name, :avatar, :introduction)
    end  
end
