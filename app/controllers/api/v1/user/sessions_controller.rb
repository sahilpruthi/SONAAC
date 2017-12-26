class Api::V1::User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
     user = warden.authenticate!(auth_options)
    if user
        hmac_secret = 'my$ecretK3y'
        exp = Time.now.to_i + 4 * 3600
        exp_payload = { :data => 'data', :exp => exp }
        token = JWT.encode exp_payload, hmac_secret, 'HS256'
        render json: {status: true, data: {user: user, token: token}}
    else
        render jons: {status: false}
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
