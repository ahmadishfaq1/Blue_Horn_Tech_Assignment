# app/controllers/shifts_controller.rb
class ShiftsController < ApplicationController
  before_action :set_shift, only: [:start_visit, :end_visit]

  def show
    @caregiver = Caregiver.first # Hardcoded for simplicity
    @shift = @caregiver.shifts.first # Assuming one shift for demo
  end

  def start_visit
    if @shift.start_visit(params[:latitude], params[:longitude])
      render json: { message: "Visit started successfully." }, status: :ok
    else
      render json: { error: "Visit has already been started and not ended yet." }, status: :unprocessable_entity
    end
  end

  def end_visit
    if @shift.end_visit(params[:latitude], params[:longitude])
      render json: { message: "Visit ended successfully." }, status: :ok
    else
      render json: { error: "Cannot end visit before starting one." }, status: :unprocessable_entity
    end
  end

  private

  def set_shift
    @shift = Shift.find_by(id: params[:id])
    render json: { status: 'error', message: 'Shift not found' }, status: :not_found unless @shift
  end
end
