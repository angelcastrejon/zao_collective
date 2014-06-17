class StaticPagesController < ApplicationController
  def home
  	flash[:alert] = "Welcome, to ZAO! Enjoy your stay."
  end

  def help
  end

  def about
  end

  def contact
  end
end
