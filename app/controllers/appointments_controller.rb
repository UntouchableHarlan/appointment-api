class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :destroy]

  # GET /appointments
  def index
    @appointments = Appointment.all

    render json: @appointments, status: 200
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)


    if @appointment.valid_check && @appointment.save
      render json: @appointment, status: 201, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment, status: 200, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.find(params[:id])
    unless @appointment.nil?
      @appointment.destroy
      head 204
    else
      head 404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def appointment_params
      params.require(:appointment).permit(:name, :email, :start_time, :end_time, :date, :day, :month, :year)
    end
end
