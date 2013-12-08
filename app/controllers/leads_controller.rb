class LeadsController < ApplicationController
  after_filter :subscribe, :only => [:create, :update]
  expose(:lead){
    @lead ||= params[:id] ? Lead.find(params[:id]) : Lead.new(params[:lead])
  }

  def create
    lead.status = 'new'
    lead.remoteip = request.remote_ip
    if lead.save
      flash[:notice] = t(:contacts_thanks)
      redirect_to thanks_path
    else
      render "new"
    end
  end

  private
  def subscribe
    #if params[:lead][:newsletter]
    #  lead.subscribe
    #end
  end
end

