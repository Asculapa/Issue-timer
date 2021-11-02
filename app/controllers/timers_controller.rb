class TimersController < ApplicationController
  def index
    render json: Timer.all
  end
end
