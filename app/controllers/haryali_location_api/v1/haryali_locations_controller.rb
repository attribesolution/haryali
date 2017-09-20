class HaryaliLocationApi::V1::HaryaliLocationsController < ApplicationController
  before_action :set_location, only: [:show]
  
  # GET /haryali_location_api/v1/haryali_locations/1.json
  def show
  end

  # GET /haryali_location_api/v1/haryali_locations.json
  def index
    @locations = HaryaliLocation.all.order(created_at: :DESC)
  end

  private
    def set_location
      @location = HaryaliLocation.where(id: params[:id]).first
      if @location.nil?
        render json:  {
                        meta: {
                          success: false,
                          status: 401,
                          message: "Invalid location id."
                        },
                        data: {}
                      }, status: 401
        return
      end
    end
end
