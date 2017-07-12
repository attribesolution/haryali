class PlantsController < ApplicationController
  before_action :set_plant, only: [:show]

  def show
  end

  def new
  	@plant = Plant.new
  end

  def create
  	@plant = Plant.new(plant_params)
    if @plant.save
      redirect_to action: "show", id: @plant.id
    else
      render :new
    end
  end

  private
    def set_plant
      @plant = Plant.find_by_id(params[:id])
    end

    def plant_params
      params.require(:plant).permit(:name, :detail, :price, :image)
    end
end
