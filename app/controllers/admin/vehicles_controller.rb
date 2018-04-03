class Admin::VehiclesController < ApplicationController

	before_action :set_vehicle, except: %i(index vehicle_sheet)

	def index
		@vehicles = Vehicle.all
	end

	def edit
		@vehicle
	end

	def show;end

	def update
		if @vehicle.update(vehicles_params)
			redirect_to admin_vehicle_index_path
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
