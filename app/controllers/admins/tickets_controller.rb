class Admins::TicketsController < AdminController
  expose(:tickets){
    if current_admin.is_admin
      current_account.tickets.order("id DESC").scoped{}
    else
      current_admin.driver_tickets.order("id DESC").scoped{}
    end
  }
  expose(:ticket, attributes: :ticket_params)

  def create
    ticket.created_by = current_admin
    if ticket.save
      redirect_to(admins_tickets_path)
    else
      render :new
    end
  end

  def update
    if ticket.update_attributes(ticket_params)
      redirect_to(admins_tickets_path)
    else
      render :edit
    end
  end

  private
  def ticket_params
    params.require(:ticket).permit!
  end
end


