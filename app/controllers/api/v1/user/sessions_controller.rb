class Api::V1::User::SessionsController < ApiController
  before_action :authenticate_user, only: [:destroy]
  # require 'mixpanel-ruby'

  # POST /resource/sign_in
  def create
    user = auth_user_by_email
    if user
      user.update_attributes(fcm_token: params[:fcm_token]) if params[
        :fcm_token].present?
      session[:user] = user
      render json: { status: true, user: user }
    else
      return unauthorize
    end
  end

  # api/v1/users/sign_out
  def destroy
    if @user.present?
      @user.update_attribute(:fcm_token, '')
      session[:user].clear
      render json: { status: true, message: 'logout successfully' }
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
