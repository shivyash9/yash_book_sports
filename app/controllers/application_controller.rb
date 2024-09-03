class ApplicationController < ActionController::API
  before_action :authenticate_request

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    @current_user = User.find_by(id: decode_token(token)) if token
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  private

  def decode_token(token)
    return nil if token.blank?
    decoded = JWT.decode(token, ENV["JWT_SECRET"])[0]
    return nil if decoded["exp"] < Time.now.to_i
    decoded["user_id"]
  rescue JWT::DecodeError
    nil
  end
end
