class LocationsController < ApplicationController
  before_action :set_location, only: [:show]

  def show
  end

  def new
  	@location = Location.new
  end

  def create
  	@location = Location.new(location_params)
    if @location.save
      redirect_to action: "show", id: @location.id
    else
      render :new
    end
  end

  private
    def set_location
      @location = HaryaliLocation.find_by_id(params[:id])
    end

    def location_params
      params.require(:location).permit(:type, :lat, :lng, :address, :target)
    end
end
