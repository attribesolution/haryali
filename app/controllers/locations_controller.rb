class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :user_admin, only: [:new, :create, :index]
  before_action :set_location, only: [:show]

  # GET /locations/1
  def show
    @timeline_events = @location.timeline_events.order(created_at: :DESC)
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

  def timeline_event
    @location = Location.find(params[:haryali_location][:location_id])
    params[:haryali_location][:timeline_events_attributes].values.each do |event|
      timeline_event = TimelineEvent.new(title: event[:title], caption: event[:caption], image: event[:image], location_id: @location.id)
      timeline_event.save
    end
    redirect_to location_path(@location)
  end

  private
    def set_location
      @location = Location.find_by_id(params[:id])
    end

    def location_params
      params.require(:location).permit(:type, :lat, :lng, :address, :optional_address, :target, :image, timeline_events_attributes: [:id, :title, :caption, :image, :_destroy])
    end

    def user_admin
      unless current_user && current_user.role == 'admin'
        redirect_to root_path
      end
    end
end
