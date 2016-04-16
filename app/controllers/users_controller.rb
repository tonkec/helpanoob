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
  before_action :disable_like, only: [:profile, :update, :show]
  skip_before_filter :verify_authenticity_token, :only => :destroy if Rails.env.test? 
  before_action :disable_link, only: [:profile, :show]

  def profile
    @comments = current_user.comments.page(params[:page]).per(2)
    @posts = current_user.posts.page(params[:page]).per(2)
    @skills = current_user.skills
    @new_skill = Skill.new
    @user_social_links = [current_user.first_social_link,
                   current_user.second_social_link,
                   current_user.third_social_link]
    respond_to do |format|
      format.js 
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    @comments = @user.comments
    @posts = @user.posts.page(params[:page]).per(2)

    if current_user.id == @user.id
      redirect_to profile_path
    end
  end

  def edit
    @user = current_user 
  end

  def update 
    respond_to do |format|
      if current_user.update_attributes(user_params)
       format.html {
         redirect_to profile_path
         flash.now[:success] = "Account updated!"
       }

       format.js {
         flash.now[:success] = "Account updated!"
         redirect_to profile_path
       }
      else
        format.html {render "profile"}
      end
    end
  end

  def destroy

    if current_user.destroy
      flash.now[:success] = "I am sorry to see you go :/"
      redirect_to root_path
    end
  end

  def disable_link
    @disable_link = false
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :last_name, :first_name, :avatar, :introduction,
                                    :first_social_link, :second_social_link, :third_social_link,
                                    :first_learning_platform, :second_learning_platform, :third_learning_platform,
                                    :experience, :website
                                  )
    end  

end
