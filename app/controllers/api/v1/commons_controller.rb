class Api::V1::CommonsController < ApiController

	 before_action :authenticate_user, only: %i(get_driver)

	def get_driver
		drivers = Driver.near([params[:latitude], params[:longitude]], 5, :units => :km)
		Driver.send_notification(params[:devises])
    # render json: { status: :ture, available_drivers: drivers }
  end


  def check_user
    user = User.find_by_email(params[:email])
    if user.present?
      render json: { status: :true, message: "User already register with the same email"}
    else
      render json: { status: false }
    end
  end

  def send_notification
	end
end
