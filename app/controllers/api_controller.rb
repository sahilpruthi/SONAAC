class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  private
  def authenticate_user
    if params[:id].present?
      @user = User.find(params[:id])
      if @user.nil?
        return unauthorize
      end
    end
  end

  def current_user
    @user
  end

  def authenticate_driver
    if params[:id].present?
      @driver = Driver.find(params[:id])
      if @driver.nil?
        return unauthorize
      end
    end
  end


  def unauthorize
    render json: { status: false, message: "Invalid email or password"}
  end

end
