class Api::V1::Driver::SessionsController < ApiController
  before_action :authenticate_driver, only: [:destroy]

  # GET /resource/sign_in

  # POST /resource/sign_in
  def create
    driver = Driver.find_by(driver_unique_number: params[:driver_key])
    vehicle = Vehicle.find_by(vehicle_unique_number: params[:vehicle_key])
    if driver.present? && vehicle.present?
      driver.update_attributes(fcm_token: params[:fcm_token]) if params[
        :fcm_token].present?
        driver.vehicle_drivers.create(vehicle_id: vehicle.id)
        session[:driver] = driver
      render json: { status: true, driver: driver }
    else
      return unauthorize_driver
    end
  end

  #  DELETE /api/v1/drivers/sign_out
  def destroy
    if @driver.present?
      @driver.update_attribute(:fcm_token, '')
      session[:driver].clear
      render json: {status: true, message: 'logout successfully'}
    end
  end

end
