class StaticPagesController < ApplicationController
  def home
    @posts = Post.all
    @groups = Group.all
  end
end