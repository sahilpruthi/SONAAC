class Api::V1::Driver::RegistrationsController < ApiController
  before_action :authenticate_driver, only: %i(update)
  # POST /resource

  def create
    resource = Driver.new(driver_params)
    hmac_secret = 'my$ecretK3y'
    exp = Time.now.to_i + 4 * 3600
    exp_payload = { :data => 'data', :exp => exp }
    token = JWT.encode exp_payload, hmac_secret, 'HS256'
    resource.token = token
    begin
      resource.save!
      render json: { status: true, user: resource }
    rescue => error
      render json: { status: false, message: error.message }
    end
  end

  def update
    if @driver.update_attributes(driver_params)
      render json: { status: true, user: @user }
    else
      render json: { status: false }
    end
  end

  private
  def driver_params
    params.permit( :email, :name, :password, :aadhar_number, :dl_number, :permanenet_address,
      :temprorary_address, :car_number, :dl_image, :car_registration_number, :latitude, :longitude,
       :fcm_token )
  end
end
