class ApplicationController < ActionController::API
  before_action :authorized

  SECRET_TOKEN_KEY = Rails.application.credentials.secret_token_key

  def encode_token(payload)
    JWT.encode(payload, SECRET_TOKEN_KEY)
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decode_token
    if auth_header
      # header: { 'Authorization': 'Bearer <token>' }
      token = auth_header.split(' ').last
      begin
        JWT.decode(token, SECRET_TOKEN_KEY, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decode_token
      user_id = decode_token.first['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'You are not authorized' }, status: :unauthorized unless logged_in?
  end
end
