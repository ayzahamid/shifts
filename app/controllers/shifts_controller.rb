# frozen_string_literal: true

class ShiftsController < ApplicationController
  before_action :set_worker

  def create
    @shift = @worker.shifts.build(shift_params)

    if @shift.save
      render json: @shift, status: :created
    else
      render json: @shift.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def set_worker
    @worker = Worker.find(params[:worker_id])
  end

  def shift_params
    params.require(:shift).permit(:start_time, :end_time)
  end
end
