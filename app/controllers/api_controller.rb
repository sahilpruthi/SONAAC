class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :authenticate_user

  private
  def authenticate_user
    if request.headers['X-USER-TOKEN']
      user_token = sanitize(request.headers['X-USER-TOKEN'])
      @user = User.find_by_token(user_token)
      #Unauthorize if a user object is not returned
      if @user.nil?
        return unauthorize
      end
    else
      return unauthorize
    end
  end

  def unauthorize
    head status: :unauthorized
    return false
  end

end
