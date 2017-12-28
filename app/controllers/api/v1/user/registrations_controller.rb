class Api::V1::User::RegistrationsController < ApiController

  # GET /resource/sign_up
  def new
  end

  # POST /resource
  def create
    resource = User.new(sign_up_params)
    hmac_secret = 'my$ecretK3y'
    exp = Time.now.to_i + 4 * 3600
    exp_payload = { :data => 'data', :exp => exp }
    token = JWT.encode exp_payload, hmac_secret, 'HS256'
    resource.token = token
    begin
      resource.save!
      render json: { status: true, user: resource}
    rescue => error
      render json: { status: false, message: error}
     end
  end

  def sign_up_params
    params.permit(:email, :user_name, :password, :phone_number, :emergency_number)
  end

 
end
