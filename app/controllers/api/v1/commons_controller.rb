class Api::V1::CommonsController < ApiController

	 before_action :authenticate_user, only: %i(get_nearest_drivers notify_cutomer_for_price
    get_drivers_offer forgot_password start_trip)
   before_action :authenticate_driver,  only: %i(notify_cutomer_for_price get_driver
    driver_forgot_password start_trip)

	def get_nearest_drivers
    if @user.present?
      driver_ids = []
      vehicles = Vehicle.where(vehicle_type: params[:vehicle_type])
      vehicles.each do |vehicle|
        vehicle_driver = vehicle.drivers
        driver_ids << vehicle_driver.last.id if vehicle_driver.present?
      end
      drivers = Driver.where(id: driver_ids).near(
        [params[:latitude], params[:longitude]], 2, :units => :km)
      if drivers.present?
  		  Driver.send_notification(drivers.pluck(:fcm_token).compact, @user,
          params[:source_latitude], params[:source_longitude], params[:destination_latitude],
          params[:destination_longitude])
        render json: { status: true, drivers: drivers }
      else
        render json: { status: false, available_drivers: 'No Driver Available in your location' }
      end
    else
      render json: { status: false, available_drivers: 'No User Available' }
    end

  end

  def get_drivers_offer
    offers = @user.driver_user_fairs.where(fair_status: 'offered')
    render json:{ status: true, drivers: offers.map(&:detail_object)}
  end

  def check_user
    user = User.find_by_email(params[:email])
    if user.present?
      render json: { status: true, message: "User already register with the same email" }
    else
      render json: { status: false }
    end
  end

  def get_driver
    render json: { status: true, driver: @driver }
  end


  def forgot_password
    UserMailer.forgot_password(@user).deliver_now
    render json: {status: true, message: 'mail send successfully'}
  end

  def driver_forgot_password
    UserMailer.driver_forgot_password(@driver).deliver_now
    render json: {status: true, message: 'mail send successfully'}
  end

  def start_trip
    if @driver.present? && @user.present?
      fair = @driver.driver_user_fairs.where(user_id: @user.id, fair_status: 'offered')
      if fair.present?
        fair.first.update_attribute(:fair_status, 'started')
        driver_fairs = @user.driver_user_fairs.where(fair_status: 'offered').destroy_all
        render json: { status: true, message: 'Trip Started' }
      else
        render json: { status: true, message: "Driver hav't offered you any trip" }
      end
    else
      render json: { status: false, message: 'Something went wrong' }
    end
  end

  def notify_cutomer_for_price
    if @driver.present? && @user.present?
      @driver.driver_user_fairs.create(user_id: params[:user_id], fair_status: 'offered', price: params[:price])
      notified =  User.send_notification(@user.fcm_token, @driver)
      render json: { status: true, message: 'notification  send' }
    else
      render json: { status: true, message: 'driver or user not present' }
    end
	end
end
