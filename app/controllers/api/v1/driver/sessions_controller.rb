class Api::V1::Driver::SessionsController < ApiController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in

  # POST /resource/sign_in
  def create
     driver = Driver.find_by_driver_unique_number(params[:key])
    if driver
      driver.update_attributes(fcm_token: params[:fcm_token]) if params[:fcm_token].present?
      render json: { status: true, driver: driver }
    else
      return unauthorize
    end
  end

end
