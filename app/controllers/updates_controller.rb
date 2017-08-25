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
    @update = Update.new(update_params)
    if @update.save!
      UserMailer.update_email(@update.lead).deliver
      redirect_to lead_path(@update.lead_id)
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
