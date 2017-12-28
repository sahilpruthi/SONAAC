class Api::V1::User::SessionsController < ApiController
  # before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  def create
    binding.pry
     user = auth_user_by_email
    if user
        TRACKER.people.increment(user.id, {no_of_logins: 1})
        render json: {status: true, data: {user: user}}
    else
        render jons: {status: false}
    end
  end

  private
  def auth_user_by_email
    binding.pry
    user = User.find_by_email(user_params[:email])

    if user && user.valid_password?(user_params[:password])
      return user
    end
    return unauthorize
  end

  def user_params
    params.permit(:email, :password)
  end
end
