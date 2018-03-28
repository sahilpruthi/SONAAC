class Admin::UsersController < ApplicationController

	before_action :set_vehicle, except: %i(index)

	def index
		@vehicles = Vehicle.all
	end

	def edit
		@vehicle
	end

	def update
		if @vehicle.update(users_params)
			redirect_to admin_vehicle_index_path
		end
	end

	private
		def set_vehicle
			@vehicle = Vehicle.find(params[:id])
		end

		def users_params
			params.require(:user).permit(:email, :phone_number, :emergency_number,
			 :full_name)
		end

end
