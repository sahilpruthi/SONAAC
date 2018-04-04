class Admin::AdminSessionController < ApplicationController

	def login
		admin = User.find_by(email: admin_params[:email])
		if admin.present? && admin.type == 'Admin'
			if admin.valid_password?(admin_params[:password])
				sign_in(admin)
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

	def home;end

	def index;end

	def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    flash[:success] = "logout successfully"
    yield if block_given?
    redirect_to root_path	
	end

	private
	def admin_params
		params.require(:admin).permit(:email, :password)
	end
	
end
