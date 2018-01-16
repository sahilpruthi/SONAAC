class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  private
  def authenticate_user
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      if @user.nil?
        return unauthorize
      end
    end
  end

  def current_user
    @user
  end

  def authenticate_driver
    if params[:driver_id].present?
      @driver = Driver.find(params[:driver_id])
      if @driver.nil?
        return unauthorize
      end
    end
  end


  def unauthorize
    render json: { status: false, message: "Invalid email or password"}
  end

  def unauthorize_driver
    render json: { status: false, message: "Invalid driver id or cab id"}
  end

end
