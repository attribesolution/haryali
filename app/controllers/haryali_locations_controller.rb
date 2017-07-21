class HaryaliLocationsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
	before_action :set_location, only: [:edit, :update]

  # GET /haryali_locations/1/edit 
  def edit
  end

  # POST /haryali_locations/1 
  def update
    if @location.update(location_params)
      redirect_to location_url
    else
      redirect_to new_location_url
    end
  end

  private 
    def set_location
      @location = HaryaliLocation.find_by_id(params[:id])
    end

    def location_params
      params.require(:haryali_location).permit(:type, :lat, :lng, :address, :target, timeline_events_attributes: [:id, :title, :caption, :image, :_destroy])
    end
end
