class Api::V1::Driver::SessionsController < ApiController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in

  # POST /resource/sign_in
  def create
    driver = Driver.find_by(driver_unique_number: params[:driver_key])
    vehicle = Vehicle.find_by(vehicle_unique_number: params[:vehicle_key])
    if driver.present? && vehicle.present?
      driver.update_attributes(fcm_token: params[:fcm_token]) if params[
        :fcm_token].present?
        driver.vehicle_drivers.create(vehicle_id: vehicle.id)
      render json: { status: true, driver: driver }
    else
      return unauthorize_driver
    end
  end
end
