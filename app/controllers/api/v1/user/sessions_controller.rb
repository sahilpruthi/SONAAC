class Api::V1::User::SessionsController < ApiController
  # before_action :configure_sign_in_params, only: [:create]
  # require 'mixpanel-ruby'

  # POST /resource/sign_in
  def create
     user = auth_user_by_email
    if user
      # TRACKER.people.increment(user.id, {no_of_logins: 1})
      render json:{ status: true, data: {user: user} }
    else
      return unauthorize
    end
  end

  private
  def auth_user_by_email
    user = User.find_by_email(user_params[:email])
    if user && user.social_media.present?
      return user
    else
      if user && user.valid_password?(user_params[:password])
        return user
      end
      return nil
    end
  end

  def user_params
    params.permit(:email, :password)
  end
end
