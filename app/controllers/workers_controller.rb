# frozen_string_literal: true

class WorkersController < ApplicationController
  before_action :set_worker, only: %i[show update destroy]

  def index
    @workers = Worker.all
    render json: @workers
  end

  def show
    render json: @worker
  end

  def create
    @worker = Worker.new(worker_params)

    if @worker.save
      render json: @worker, status: :created, location: @worker
    else
      render json: @worker.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @worker.update(worker_params)
      render json: @worker
    else
      render json: @worker.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @worker.destroy
  end

  private

  def set_worker
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.require(:worker).permit(:name)
  end
end
