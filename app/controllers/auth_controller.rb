class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [ :signup, :login ]

  def signup
    user = User.new(user_params)

    if user.save
      render json: { message: "User created successfully", user: user.as_json }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      render json: { token: token, user: user.as_json }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def encode_token(payload)
    expiration = 24.hours.from_now.to_i
    payload[:exp] = expiration
    JWT.encode(payload, ENV["JWT_SECRET"])
  end
end
