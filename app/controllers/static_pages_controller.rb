class StaticPagesController < ApplicationController
  def home
    @home_posts = current_user.posts if user_signed_in?
    @groups = Group.all
  end
end