class Admins::AdminsController < AdminController
  before_filter :check_password_submitted, :only => :update
  before_filter :check_if_is_admin
  expose(:admins){ current_account.admins.order("id DESC").scoped{} }
  expose(:admin, attributes: :admin_params)

  def create
    if admin.save
      flash[:notice] = t(:admin_was_successfully_created)
      redirect_to(admins_admins_path)
    else
      render :new
    end
  end

  def update
    if admin.update_attributes(params[:admin])
      flash[:notice] = t(:admin_was_successfully_updated)
      redirect_to(admins_admins_path)
    else
      render :edit
    end
  end

  private
  def admin_params
    params.require(:admin).permit!
  end
  def check_password_submitted
    if params[:admin][:password].blank?
      params[:admin].delete("password")
      params[:admin].delete("password_confirmation")
      admin.updating_password = false
    else
      admin.updating_password = true
    end
  end

  def check_if_is_admin
    unless current_admin.is_admin
      flash[:notice] = t(:admin_was_successfully_updated)
      redirect_to(admins_dashboard_path)
    end
  end
end

