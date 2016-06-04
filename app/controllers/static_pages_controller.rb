class StaticPagesController < ApplicationController
  layout false, only: [:home, :about]
  
  def home
  end

  def support
  end

  def about
  end
end