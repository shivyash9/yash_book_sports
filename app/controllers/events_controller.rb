class EventsController < ApplicationController
  # GET /events
  def index
    if params[:location_id]
      @events = Event.where(location_id: params[:location_id])
    else
      @events = Event.all
    end

    @events = @events.select do |event|
      confirmed_orders_count = Order.where(event_id: event.id, status: 'confirmed').count
      event.total_seats > confirmed_orders_count
    end

    render json: @events.as_json(include: [:sport, :location])
  end

  # GET /events/:id
  def show
    @event = Event.find(params[:id])
    render json: @event.as_json(include: [:sport, :location])
  end
end
