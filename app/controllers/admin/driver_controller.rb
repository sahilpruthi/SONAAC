class Admin::DriverController < ApplicationController

	before_action :set_vehicle, except: %i(index)

	def index
		@users = User.all
	end

	def edit
		@user
	end

	def update
		if @user.update(vehicles_params)
			redirect_to admin_user_index_path
		end
	end

	private
		def set_vehicle
			@user = user.find(params[:id])
		end

		def vehicles_params
			params.require(:user).permit(:email, :password, :vehicle_number,
			 :name)
		end

end
