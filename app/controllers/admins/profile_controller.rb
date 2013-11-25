class Admins::ProfileController < AdminController
  before_filter :check_password_submitted, :only => :update
  expose(:admin){ current_admin }
  def update
    if admin.update_attributes(params[:admin])
      sign_in(current_admin, :bypass => true)
      flash[:notice] = t(:profile_was_successfully_updated)
      redirect_to admins_dashboard_path
    else
      render :edit
    end
  end

  private
  def check_password_submitted
    if params[:admin][:password].blank?
      params[:admin].delete("password")
      params[:admin].delete("password_confirmation")
      admin.updating_password = false
    else
      admin.updating_password = true
    end
  end
end


