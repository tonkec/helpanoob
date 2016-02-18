class StaticPagesController < ApplicationController
  def home
    @home_posts = Post.all
    @groups = Group.all
  end


end