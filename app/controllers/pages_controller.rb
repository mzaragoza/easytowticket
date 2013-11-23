class PagesController < ApplicationController
  protect_from_forgery with: :exception
  def index
  end

  def ping
    render :layout => false
  end

end

