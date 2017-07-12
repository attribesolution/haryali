class PlantsController < ApplicationController
  before_action :set_plant, only: [:show, :edit, :update]

  # GET /plants/1 
  def show
  end

  # GET /plants/new 
  def new
  	@plant = Plant.new
  end

  # POST /plants 
  def create
  	@plant = Plant.new(plant_params)
    if @plant.save
      redirect_to action: "show", id: @plant.id
    else
      render :new
    end
  end

  # GET /plants/1/edit 
  def edit
  end

  # PATCH/PUT /plants/1 
  def update
    if @plant.update(plant_params)
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
