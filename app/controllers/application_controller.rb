class ApplicationController < ActionController::API
  private

  def auth_header
    request.headers["Authorization"]
  end

  def authorize_user
    unless current_user
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def current_user
    if decode_token
      user_id = decode_token[0]["user_id"]
      @user = User.find_by(id: user_id)
    else
      render json: { message: "Did not find user." }, status: :unauthorized
    end
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.jwt_secret)
  end

  # header: { 'Authorization': 'Bearer <token>' }
  def decode_token
    if auth_header
      token = auth_header.split(" ")[1]
      begin
        JWT.decode(token, Rails.application.credentials.jwt_secret, true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
