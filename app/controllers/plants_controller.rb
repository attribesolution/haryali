class PlantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show, :index, :destroy]
  before_action :set_plant, only: [:show, :edit, :update, :destroy]

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
    if validate_image_size(@plant.image)
      render :new
    else
      if @plant.save
        redirect_to action: "show", id: @plant.id
      else
        render :new
      end
    end
  end

  # GET /plants/1/edit 
  def edit
  end

  # PATCH/PUT /plants/1 
  def update
    if validate_image_size(plant_params[:image])
      render :new
    else
      if @plant.update(plant_params)
        redirect_to action: "show", id: @plant.id
      else
        render :new
      end
    end
  end

  # GET /plants
  def index
    @plants = Plant.all
  end

  # DELETE /plants/1
  def destroy
    redirect_to plants_url
    # @doctor.destroy
    # respond_to do |format|
    #   format.html { redirect_to doctors_url, notice: 'Doctor was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    def set_plant
      @plant = Plant.find_by_id(params[:id])
    end

    def plant_params
      params.require(:plant).permit(:name, :detail, :price, :image)
    end
    
    def validate_image_size (image)
      if image.nil?
        return false
      else
        if image.size > 0.5.megabytes
          flash.now[:error] = "Image size should be less than 500KB" 
          return true
        else
          return false
        end
      end
    end
end
