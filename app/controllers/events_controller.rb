class EventsController < ApplicationController
  # GET /events
  def index
    if params[:location_id]
      @events = Event.where(location_id: params[:location_id], event_visibility: "public")
    else
      @events = Event.where(event_visibility: "public")
    end

    @events = @events.map do |event|
      confirmed_orders_count = Order.where(event_id: event.id, status: "confirmed").sum(:seats)
      available_seats = event.total_seats - confirmed_orders_count
      event.as_json(include: [ :sport, :location ]).merge("available_seats" => available_seats)
    end
    render json: @events.as_json(include: [ :sport, :location ])
  end

  # GET /events/:id
  def show
    @event = Event.find(params[:id])
    confirmed_orders_count = Order.where(event_id: @event.id, status: "confirmed").sum(:seats)
    available_seats = @event.total_seats - confirmed_orders_count

    event_json = @event.as_json(include: [ :sport, :location ])
    event_json["available_seats"] = available_seats

    render json: event_json
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event not found" }, status: :not_found
  end
end
