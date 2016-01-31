class StaticPagesController < ApplicationController
  def home
    @home_posts = Post.limit(5)
    @groups = Group.all
  end
end