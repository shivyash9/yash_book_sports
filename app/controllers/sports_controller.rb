# app/controllers/sports_controller.rb
class SportsController < ApplicationController
  # GET /sports
  def index
    @sports = Sport.all
    render json: @sports
  end

  # POST /sports
  def create
    @sport = Sport.new(sport_params)
    if @sport.save
      render json: @sport, status: :created
    else
      render json: @sport.errors, status: :unprocessable_entity
    end
  end

  private


  def sport_params
    params.permit(:name, :description, :image)
  end
end
