class Admin::AdminSessionController < ApplicationController

	def login
		admin = Admin.find_by(email: admin_params[:email])
		if admin.present?
			if admin.valid_password?(admin_params[:password])
				session[:admin] = admin
				redirect_to admin_home_path, notice: 'Welcome Admin in Sonaac'
			else
				flash[:error] = "email or password mismatch"
    		render "index"
			end
		else
			flash[:error] = "email or password mismatch"
  		render "index"
		end	
	end

	def home; end

	def index; end

	private

	def admin_params
		params.require(:admin).permit(:email, :password)
	end

end
