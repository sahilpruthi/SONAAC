class Api::V1::CommonsController < ApiController

	 before_action :authenticate_user, only: %i(get_driver)

	def get_driver
		drivers = Driver.near([params[:latitude], params[:longitude]], 2, :units => :km)
    if drivers.present?
		  notified =  Driver.send_notification(drivers.pluck(:fcm_token).compact)
      puts(notified.dig(:response))
      render json: { status: true, drivers: drivers }
    else
      render json: { status: :false, available_drivers: 'No Driver Available in your location' }
    end
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
