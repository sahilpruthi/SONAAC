class Admin::VehiclesController < ApplicationController

	before_action :set_vehicle, except: %i(index vehicle_sheet)

	def index
		@vehicles = Vehicle.order(id: :desc)
	end

	def edit
		@vehicle
	end

	def show;end

	def update
		block_unblock = @vehicle.is_block ? false : true
		if @vehicle.update_attributes(is_block: block_unblock)
			redirect_to admin_vehicles_path
		end
	end

	def vehicle_sheet
	  Vehicle.destroy_all
	  Station.destroy_all
	  Vehicle.import(params[:file])
  	redirect_to admin_home_path, notice: "Products imported."

	end

	private
		def set_vehicle
			@vehicle = Vehicle.find(params[:id])
		end

		def vehicles_params
			params.require(:vehicle).permit(:registration_no, :model_no, :vehicle_number,
			 :name)
		end

end
