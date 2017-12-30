class Api::V1::Driver::SessionsController < ApiController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in

  # POST /resource/sign_in
  def create
     user = Driver.find_by_driver_unique_number(params[:key])
    if user
      render json: { status: true, user: user }
    else
      return unauthorize
    end
  end

end
