class AuthController < ApplicationController
  # POST /signup
  skip_before_action :verify_authenticity_token, only: [:signup, :login]

  def signup
    user = User.new(user_params)

    if user.save
      render json: { message: 'User created successfully', user: user.as_json }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      render json: { token: token, user: user.as_json }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def encode_token(payload)
    JWT.encode(payload, 'Yash')
  end
end
