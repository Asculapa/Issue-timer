class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # Create account
  def create
    @user = User.create(users_params)

    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: { user: @user, token: token }, status: :created
    else
      render json: { error: 'Invalid arguments' }, status: :bad_request
    end
  end

  # Logging in
  def login
    @user = User.find_by(email: users_params[:email])

    if @user && @user.authenticate(users_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end


  def auto_login
    token = auth_header.split(' ').last

    render json: { user: @user, token: token }
  end

  def users_params
    params.permit(:username, :email, :password)
  end
end
