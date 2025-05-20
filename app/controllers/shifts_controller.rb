# app/controllers/shifts_controller.rb
class ShiftsController < ApplicationController
  def show
    @caregiver = Caregiver.first # Hardcoded for simplicity
    @shift = @caregiver.shifts.first # Assuming one shift for demo
  end

  def start_visit
    @shift = Shift.find(params[:id])
    if @shift.start_visit(params[:latitude], params[:longitude])
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end

  def end_visit
    @shift = Shift.find(params[:id])
    if @shift.end_visit(params[:latitude], params[:longitude])
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: :unprocessable_entity
    end
  end
end