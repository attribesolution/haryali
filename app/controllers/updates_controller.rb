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
    if params["update"]
      @lead = Lead.find_by(id: params["update"][:lead_id])
      update = Update.new(title: params["update"][:title], description: params["update"][:description], image: params["update"][:image], lead_id: @lead.id)
      if update.save!
        UserMailer.update_email(@lead).deliver
        redirect_to lead_path(@lead.id)
      else
        render :new
      end
    else
      lead = Lead.find(params[:lead_id])
      lead.update(status: "Planted", planted_date: params[:planted_date], comment: params[:comment])
      update = Update.new(image: params[:image], lead_id: lead.id)
      update.save!
      if lead.save
        UserMailer.notify_email_planted(lead).deliver
        redirect_to leads_url, notice: 'Lead was updated successfully'
      else
        render :new
      end
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
