class OrdersController < ApplicationController
  # POST /orders

  ###TO DO: Handle this in real case
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    user = User.find_by(id: params[:user_id])
    event = Event.find_by(id: params[:event_id])

    if user.nil?
      return render json: { error: 'User not found' }, status: :not_found
    end

    if event.nil?
      return render json: { error: 'Event not found' }, status: :not_found
    end

    if event.total_seats > Order.where(event: event, status: 'confirmed').count
      order = Order.new(user: user, event: event, status: 'confirmed')
      if order.save
        render json: order.as_json(include: [:user, :event]), status: :created
      else
        render json: { error: 'Booking failed', details: order.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'No available slots' }, status: :unprocessable_entity
    end
  end
end
