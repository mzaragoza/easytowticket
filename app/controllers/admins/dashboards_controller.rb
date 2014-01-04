class Admins::DashboardsController < AdminController
  expose(:admins){ current_account.admins.where(:is_driver => true, :active => true).order("id DESC").scoped{} }
  expose(:tickets){
    if current_admin.is_admin
      current_account.tickets.order("id DESC").scoped{}
    else
      current_admin.driver_tickets.order("id DESC").scoped{}
    end
  }
end

