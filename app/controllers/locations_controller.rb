class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :user_admin, only: [:new, :create, :index]
  before_action :set_location, only: [:show]

  # GET /locations/1
  def show
  end

  # GET /locations/new
  def new
  	@location = Location.new
  end

  # POST /locations
  def create
  	@location = Location.new(location_params)
    if @location.save
      if @location.optional_address == ""
        @location.update_attribute(:optional_address, nil)
      end
      redirect_to action: "show", id: @location.id
    else
      render :new
    end
  end

  # GET /locations 
  def index
    @locations = HaryaliLocation.all.order(:created_at)
  end

  private
    def set_location
      @location = Location.find_by_id(params[:id])
    end

    def location_params
      params.require(:location).permit(:type, :lat, :lng, :address, :optional_address, :target, timeline_events_attributes: [:id, :title, :caption, :image, :_destroy])
    end

    def user_admin
      unless current_user && current_user.role == 'admin'
        redirect_to root_path
      end
    end
end
