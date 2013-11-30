class Admins::TicketsController < AdminController
  expose(:tickets){ current_account.tickets.order("id DESC").scoped{} }
  expose(:ticket, attributes: :ticket_params)

  def create
    if ticket.new(ticket_params).save
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


