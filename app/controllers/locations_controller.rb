# app/controllers/locations_controller.rb
class LocationsController < ApplicationController
  # GET /locations
  def index
    @locations = Location.all
    render json: @locations
  end

  # POST /locations
  def create
    @location = Location.new(location_params)
    if @location.save
      render json: @location, status: :created
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.permit(:name, :address, :pincode, :iframe)
  end
end
