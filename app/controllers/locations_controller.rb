class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
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
      redirect_to action: "show", id: @location.id
    else
      render :new
    end
  end

  # GET /locations 
  def index
    @locations = HaryaliLocation.all
  end

  private
    def set_location
      @location = HaryaliLocation.find_by_id(params[:id])
    end

    def location_params
      params.require(:location).permit(:type, :lat, :lng, :address, :target, timeline_events_attributes: [:id, :title, :caption, :image, :_destroy])
    end
end
