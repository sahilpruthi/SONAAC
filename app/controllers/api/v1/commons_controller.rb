class Api::V1::CommonsController < ApiController

	 before_action :authenticate_user, only: %i(get_driver)
   before_action :authenticate_driver, :authenticate_user,  only: %i(notify_cutomer_for_price)

	def get_driver
    if @user.present?
  		drivers = Driver.near([params[:latitude], params[:longitude]], 2, :units => :km)
      if drivers.present?
  		  notified =  Driver.send_notification(drivers.pluck(:fcm_token).compact, @user,
          params[:source_latitude],params[:source_longitude], params[:destination_latitude],
          params[:destination_longitude])
        render json: { status: true, drivers: drivers }
      else
        render json: { status: :false, available_drivers: 'No Driver Available in your location' }
      end
    else
      render json: { status: :false, available_drivers: 'No User Available' }
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



  def notify_cutomer_for_price
    if @driver.present? && @user.present?
      @driver.driver_user_fairs.create(user_id: params[:user_id], fair_status: 'offered', price: params[:price])
      notified =  User.send_notification(@user.fcm_token, @driver)
      render json: { status:true, message: 'notification  send'}
    else
      render json: { status:true, message: 'driver or user not present'}
    end
	end
end
