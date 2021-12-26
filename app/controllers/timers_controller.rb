class TimersController < ApplicationController
  def index
    render json: @user.timers
  end

  def show
    @timer = @user.timers.where(id: params[:id]).first

    if @timer
      render json: {
        "id": @timer.id,
        "description": @timer.description,
        "task_id": @timer.task_id,
        "user_id": @timer.user_id,
        "periods": @timer.periods
      }
    else
      render status: :not_found
    end
  end

  def create
    @timer = Timer.create(timer_params)

    if @timer.save
      render json: @timer
    else
      render json: { error: @timer.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @timer = @user.timers.where(id: params[:id]).first

    if @timer.nil?
      render json: { error: 'Timer not found!' }, status: :not_found
    elsif @timer.update(timer_params)
      render json: @timer, status: :ok
    else
      render json: { error: @timer.errors.full_messages }, status: :bad_request
    end
  end

  private

  def timer_params
    params.require(:timer).permit(:task_id, :user_id, :description).delete_if do |key, value|
      key == 'user_id' && value != @user.id
    end
  end
end
