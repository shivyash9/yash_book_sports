class ApplicationController < ActionController::API
  before_action :authenticate_request
  JWT_TOKEN_KEY = "YASH"   ### Move this to .env

  def authenticate_request
    header = request.headers["Authorization"]
    Rails.logger.info "Authorization Header: #{header}" # Debugging line
    token = header.split(" ").last if header
    Rails.logger.info "Token: #{token}" # Debugging line
    @current_user = User.find_by(id: decode_token(token)) if token
    # render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  private

  def decode_token(token)
    decoded_token = JWT.decode(token, JWT_TOKEN_KEY)[0]
    Rails.logger.info "Decoded Token: #{decoded_token.inspect}" # Debugging line
    decoded_token["user_id"]
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Error: #{e.message}" # Debugging line
    nil
  end
end
