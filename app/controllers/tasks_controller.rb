class TasksController < ApplicationController

  def show
    @task = @user.tasks.where(id: params[:id])

    if @task.exists?
      render json: @task
    else
      render status: :not_found
    end
  end

  def index
    @tasks = @user.tasks

    render json: @tasks
  end

  def create
    @task = Task.create(task_params)

    if @task.save
      @user.tasks << @task

      render json: @task
    else
      render json: { error: @task.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @task = @user.tasks.where(id: params[:id])

    if @task.exists?
      Task.destroy @task.ids

      render status: :ok
    else
      render status: :not_found
    end
  end

  def update
    @task = @user.tasks.where(id: params[:id]).first

    if @task.nil?
      render json: { error: 'Timer not found!' }, status: :not_found
    elsif @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { error: @task.errors.full_messages }, status: :bad_request
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :url, :service_id)
  end

end
