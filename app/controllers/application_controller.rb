class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :search
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do
    if current_user.nil?
      redirect_back_or root_path
      flash[:danger] = "You need to sign in or sign up before continuing."
    else
      flash[:notice] = "Record not found"
      redirect_back_or root_path
    end 
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order('created_at desc').page(params[:page]).per(5)
  end


  def after_inactive_sign_up_path_for(resource)
   root_path # Or :prefix_to_your_route
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def disable_like
    @disable_like = true
  end

  def create_notification(post, user, identifier, type)
    unless post.user.id == user.id
      Notification.create(
          user_id: post.user.id,
          notified_by_id: user.id,
          post_id: post.id,
          identifier: identifier.id,
          notice_type: type )
    end
  end

  def delete_notification(post, user, identifier, type)
    notification = Notification.find_by(
      user_id: post.user.id,
      notified_by_id: user.id,
      post_id: post.id,
      identifier: identifier.id,
      notice_type: type)
    notification.delete if notification
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:avatar, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
                                                    :username, :last_name, :first_name, :email, :avatar,
                                                    :first_social_link, :second_social_link, :third_social_link,
                                                    :first_learning_platform, :second_learning_platform, :third_learning_platform,
                                                    :experience, :website) }
  end
end
