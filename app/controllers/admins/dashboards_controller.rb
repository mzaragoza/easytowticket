class Admins::DashboardsController < AdminController

  expose(:admins){ current_account.admins.where(:is_driver => true, :active => true).order("id DESC").scoped{} }
end

