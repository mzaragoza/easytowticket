class ApplicationController < ActionController::Base
  include ApplicationHelper
  layout 'application/default'
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  expose(:environment) { Rails.env }
  expose(:current_account){ Account.first }

end
