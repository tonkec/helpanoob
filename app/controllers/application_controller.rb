class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :search
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order('created_at desc').page(params[:page]).per(5)
  end


  def after_inactive_sign_up_path_for(resource)
   landing_page_path # Or :prefix_to_your_route
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected 

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:avatar, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_social_link, :second_social_link,
                                                      :third_social_link, 
                                                      :username, :last_name, :first_name, :email, :avatar) }
  end
end
