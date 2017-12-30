class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user

  private
  def authenticate_user
    if request.headers['X-USER-TOKEN']
      @user = User.find_by_token(request.headers['X-USER-TOKEN'])
      if @user.nil?
        return unauthorize
      end
    else
      return unauthorize
    end
  end

  def current_user
    @user
  end

  def unauthorize
    render json: { status: false, message: "unauthorized"}
  end

end
