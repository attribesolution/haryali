class VisitorsController < ApplicationController
  before_action :authenticate_user! 

  def index
    if (current_user)
      @leads = Lead.where(email: current_user.email).order(created_at: :DESC)
    end
  end

  # GET /visitors/id 
  def show
    @lead = Lead.find_by_id(params[:id])
  end
end
