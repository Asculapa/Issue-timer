class PeriodsTimersController < ApplicationController
  def index
    @periods_timers = []
    @timers = []

    @timers = if params[:timer_id]
                @user.timers.where(id: params[:timer_id])
              else
                @user.timers
              end

    @timers.each do |timer|
      @periods_timers << {
        timer_id: timer.id,
        periods: timer.periods
      }
    end

    render json: @periods_timers
  end

  def create
    timer_id = periods_timers_params[:timer_id]
    @timer = @user.timers.where(id: timer_id).first
    @period = Period.create(periods_timers_params[:period])

    if @timer.nil?
      render json: { error: 'Timer not found!' }, status: :not_found
    elsif @period.save
      @timer.periods << @period
      render json: @timer
    else
      render json: { error: @timer.errors.full_messages }, status: :bad_request
    end
  end

  private

  def periods_timers_params
    params.permit(:timer_id, period: %i[start end])
  end
end
