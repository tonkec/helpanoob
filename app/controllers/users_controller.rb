class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user_posts_count = current_user.posts.count
    @user_comments_count = current_user.comments.count
    @user_posts = current_user.posts.page(params[:page]).per(5)
    @user_comments = current_user.comments.limit(5).reorder('created_at desc')
  end

   def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        UserNotifier.send_signup_email(@user).deliver
        redirect_to(@user, :notice => 'User created')
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
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
      params.require(:user).permit(:nickname, :email, :last_name, :first_name)
    end  
end