class PlantsController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :handle_error

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  def update
    found_plant = find_plant
    if found_plant
      found_plant.update(plant_params)
      render json: found_plant, status: :accepted
    else
      handle_error
    end
  end

  def destroy
    found_plant = find_plant
    if found_plant
      found_plant.destroy
      render json: {}, status: :accepted
    else
      handle_error
    end
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find_by(id: params[:id])
  end

  def handle_error
    render json: { error: 'not found' }, status: :not_found
  end
end
