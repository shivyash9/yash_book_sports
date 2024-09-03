class UsersController < ApplicationController
  # GET /my_orders
  def my_orders
    user = User.find_by(id: params[:user_id])
    if user.nil?
      render json: { error: "User not found" }, status: :not_found
      return
    end
    orders = Order.where(user: user, status: "confirmed")
    event_ids = orders.pluck(:event_id)
    events = Event.where(id: event_ids).includes(:sport, :location)

    events_with_details = events.map do |event|
      confirmed_orders_count = Order.where(event_id: event.id, user_id: user.id, status: "confirmed").sum(:seats)
      event.as_json(include: [ :sport, :location ]).merge(
        "booked_seats" => confirmed_orders_count,
      )
    end

    render json: events_with_details
  end
end
