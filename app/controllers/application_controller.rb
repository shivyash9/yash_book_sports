class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # before_action :authorize_request, except: :login

  # def current_user
  #   @current_user
  # end

  # private

  # def authorize_request
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header
  #   decoded = decode_token(header)
  #   @current_user = User.find(decoded[:user_id]) if decoded
  # rescue
  #   render json: { error: 'Not Authorizesssd' }, status: :unauthorized
  # end

  # def decode_token(token)
  #   JWT.decode(token, Rails.application.secrets.secret_key_base).first
  # end
end
