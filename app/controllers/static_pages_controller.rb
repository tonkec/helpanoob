class StaticPagesController < ApplicationController
  layout false, only: [:home]
  
  def home
  end

  def support
  end

  def about
  end
end