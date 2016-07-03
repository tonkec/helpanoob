class SignupController < ApplicationController
  def check_email_uniqueness
    availability = SignupUniquenessChecker.new.validate_email(params[:email])
    render json: { availability: availability }
  end

  def check_username_uniqueness
    availability = SignupUniquenessChecker.new.validate_username(params[:username])
    render json: { availability: availability }
  end
end
