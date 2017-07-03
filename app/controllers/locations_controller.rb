class LocationsController < ApplicationController
  before_action :set_location, only: [:show]

  def show
  end

  private
  def set_location
    @location = HaryaliLocation.find_by_id(params[:id])
  end
end
