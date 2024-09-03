class EventsController < ApplicationController
  before_action :authenticate_request

  before_action :set_event, only: [ :show ]

  # GET /events
  def index
    if params[:location_id]
      @events = Event.where(location_id: params[:location_id], event_visibility: "public")
    else
      @events = Event.where(event_visibility: "public")
    end

    if @current_user
      my_private_events = Event.where(event_visibility: "private", created_by_id: @current_user.id)
      @events = @events.or(my_private_events)
    end

    @events = @events.map do |event|
      confirmed_orders_count = Order.where(event_id: event.id, status: "confirmed").sum(:seats)
      available_seats = event.total_seats - confirmed_orders_count
      event.as_json(include: [ :sport, :location ]).merge("available_seats" => available_seats)
    end
    render json: @events
  end

  # POST /events
  def create
    @event = Event.new(event_params.merge(created_by_id: @current_user.id, event_visibility: "private"))
    order = Order.new(user: @current_user, event: @event, seats: 1, status: "confirmed")

    if @event.save && order.save
      render json: { message: "Event successfully created and your 1 seat is booked", event: @event }, status: :created
    else
      render json: { error: "Failed to create event", details: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /events/:id
  def show
    confirmed_orders_count = Order.where(event_id: @event.id, status: "confirmed").sum(:seats)
    available_seats = @event.total_seats - confirmed_orders_count

    event_json = @event.as_json(include: [ :sport, :location ])
    event_json["available_seats"] = available_seats

    render json: event_json
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Event not found" }, status: :not_found
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.permit(:name, :description, :total_seats, :start_time, :end_time, :sport_id, :location_id, :image)
  end
end
