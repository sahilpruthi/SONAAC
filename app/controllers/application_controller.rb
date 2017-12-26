class ApplicationController < ActionController::Base
  before_action :authenticate_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception




  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name,
                                      :phone_number, :emergency_number])
  end

  def authenticate_user
    if request.headers['X-USER-TOKEN']
      user_token = sanitize(request.headers['X-USER-TOKEN'])
      @user = User.find_by_token(user_token)

      if @user.nil?
        return unauthorize
      end
    else
      return unauthorize
    end

  end

end
