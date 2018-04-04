class Admin::UsersController < ApplicationController

	before_action :set_vehicle, except: %i(index)

	def index
		@users = User.all
	end

	def edit
		@users
	end

	def update
		if @users.update(users_params)
			flash[:success] = "User Updated Successfully"
			redirect_to admin_vehicle_index_path
		end
	end

	def destroy
		@user.destroy
		flash[:success] = "User Deleted Successfully"
		redirect_to admin_users_path
	end

	private
		def set_vehicle
			@user = User.find(params[:id])
		end

		def users_params
			params.require(:user).permit(:email, :phone_number, :emergency_number,
			 :full_name)
		end

end
