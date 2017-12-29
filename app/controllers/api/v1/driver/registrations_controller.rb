class Api::V1::Driver::RegistrationsController < ApiController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    resource = Driver.new(sign_up_params)
    hmac_secret = 'my$ecretK3y'
    exp = Time.now.to_i + 4 * 3600
    exp_payload = { :data => 'data', :exp => exp }
    token = JWT.encode exp_payload, hmac_secret, 'HS256'
    resource.token = token       
    begin
      resource.save!
      render json: {status: true, user: resource}
    rescue => error
      render json: {status: false, message: error.message}
    end
  end

  def sign_up_params
    params.permit(:email, :name, :password, :aadhar_number, :dl_number,
     :permanenet_address, :temprorary_address, :car_number, :car_registration_number)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
