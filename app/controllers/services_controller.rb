class ServicesController < ApplicationController

  def show
    @service = Service.where(id: params[:id]).first

    if @service
      render json: @service
    else
      render status: :not_found
    end
  end

  def index
    @service = Service.all

    render json: @service
  end

  def create
    @service = Service.find_or_create_by(service_params)

    if @service.save
      render json: @service
    else
      render json: { error: @service.errors.full_messages }, status: :bad_request
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :hostname)
  end
end
