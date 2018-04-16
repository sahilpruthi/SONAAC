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
		file_status = ''
		ActiveRecord::Base.transaction do
		  file_status  = Vehicle.import(params[:file])
		  if  file_status.include? 'at'
		  	flash[:alert] = file_status
		  	redirect_to admin_home_path
		  else
  		redirect_to admin_home_path, notice: "Vehicles imported Successfully."
	  	end
		end
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
