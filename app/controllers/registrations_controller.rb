class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    landing_page_path
  end
end