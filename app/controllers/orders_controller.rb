class OrdersController < ApplicationController
  # POST /orders

  def create
    user = User.find_by(id: params[:user_id])
    event = Event.find_by(id: params[:event_id])
    seats = params[:seats].to_i

    if user.nil?
      return render json: { error: "User not found" }, status: :not_found
    end

    if event.nil?
      return render json: { error: "Event not found" }, status: :not_found
    end

    if seats <= 0
      return render json: { error: "Invalid number of seats" }, status: :unprocessable_entity
    end

    begin
      # Lock the event row to prevent race conditions
      event.with_lock do
        # Lock the user to prevent multiple concurrent bookings by the same user
        user.with_lock do
          booked_seats = Order.where(event: event, status: "confirmed").sum(:seats)
          left_seats = event.total_seats - booked_seats

          if Order.exists?(user: user, event: event, status: "confirmed")
            return render json: { error: "Rebooking not allowed" }, status: :unprocessable_entity
          end

          if seats > left_seats
            return render json: { error: "Only #{left_seats} seats are available" }, status: :unprocessable_entity
          end

          order = Order.new(user: user, event: event, seats: seats, status: "confirmed")
          if order.save
            render json: { message: "#{seats} seats successfully booked. #{left_seats - seats} seats remaining.", order: order }, status: :created
          else
            render json: { error: "Failed to create order", details: order.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end
    rescue => e
      render json: { error: "Booking failed: #{e.message}" }, status: :unprocessable_entity
    end
  end
end
