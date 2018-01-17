class Api::V1::User::RegistrationsController < ApiController
  before_action :authenticate_user, only: %i(update)
  # POST /resource
  before_action :check_email, only: %i(create)

  def create
    if !@user.present?
      @already_exist = if !params[:email].present? || (!params[:phone_number].present? ||
       !params[:emergency_number].present?)
         false
       else
         true
       end
      params[:email] = params[:social_id].to_s+"@demo.com" unless params[
        :email].present?
      resource = User.new(user_params)
      resource.token = create_token
      begin
        resource.save!
        render json: { status: true, user: resource, already_exist: @already_exist }
      rescue => error
        render json: { status: false, message: error }
       end
    elsif @user.phone_number.present?
        render json: { status: true, user: @user, already_exist: true }
    else
        render json: { status: true, user: @user, already_exist: false }
    end
  end

  def create_token 
    hmac_secret = 'my$ecretK3y'
    exp = Time.now.to_i + 4 * 3600
    exp_payload = { data: 'data', exp: exp }
    token = JWT.encode exp_payload, hmac_secret, 'HS256'
  end

  def update
    if @user.present?
      if @user.update_attributes(user_params)
        render json: { status: true, user: @user }
      else
        render json: { status: false }
      end
    else
      render json: { status: false, message: 'Id not present!' }
    end
  end

  def check_email
    @user = if params[:email].present?
              User.find_by_email(params[:email])
            else
              User.find_by_social_id(params[:social_id])
            end
  end
private
  def user_params
    params.permit(:email, :password, :phone_number, :emergency_number,
     :full_name, :latitude, :longitude, :social_media, :social_id, :fcm_token)
  end
end
