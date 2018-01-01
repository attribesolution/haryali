class UpdatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :user_admin, only: [:new, :create]

  # GET /updates/new 
  def new
    @update = Update.new
    @lead_id = params[:lead_id]
  end

  # POST /updates 
  def create
    @lead = Lead.find_by(id: params["update"][:lead_id])
    @timeline_event = TimelineEvent.new(title: params["update"][:title], caption: params["update"][:description], image: params["update"][:image], location_id: @lead.location.id, lead_id: @lead.id)
    if @timeline_event.save!
      UserMailer.update_email(@timeline_event.lead).deliver
      redirect_to lead_path(@timeline_event.lead_id)
    else
      render :new
    end

  end

  private 
    def update_params
      params.require(:update).permit(:lead_id, :title, :description, :image)
    end

    def user_admin
      unless current_user && current_user.role == 'admin'
        redirect_to root_path
      end
    end
end
