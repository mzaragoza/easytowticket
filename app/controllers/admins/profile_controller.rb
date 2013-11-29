class Admins::ProfileController < AdminController
  before_filter :check_password_submitted, :only => :update
  expose(:admin, attributes: :admin_params){current_admin}
  def update
    if admin.update_attributes(admin_params)
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
  def admin_params
    params.require(:admin).permit(:first_name,:last_name,:phone,:email,:active,:password,:password_confirmation)
  end
end


