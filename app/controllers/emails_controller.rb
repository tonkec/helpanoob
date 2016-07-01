class EmailsController < ApplicationController
  def check_uniqueness
    availability = EmailUniquenessChecker.new.validate(params[:email])
    render json: { availability: availability }
  end
end
