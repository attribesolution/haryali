class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_location, only: [:show, :edit]

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

  def edit
  end

  private
    def set_location
      @location = HaryaliLocation.find_by_id(params[:id])
    end

    def location_params
      params.require(:location).permit(:type, :lat, :lng, :address, :target, timeline_events_attributes: [:id, :title, :caption, :image, :_destroy])
    end
end
