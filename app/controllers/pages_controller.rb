class PagesController < ApplicationController
  protect_from_forgery with: :exception
  def index
    #redirect_to admins_dashboard_path
  end

  def ping
    render :layout => false
  end

end

