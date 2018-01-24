class DriverUserFair < ApplicationRecord
	belongs_to :driver
	belongs_to :user

	enum fair_status: %i(offered confirmed started completed cancelled)

	def detail_object
		driver = self.driver
		vehicle = driver.vehicle_drivers.last.vehicle
		return self.as_json.merge ({
					name: driver.name,
					email: driver.email,
					phone_number: driver.phone_number,
					vehicle_number: vehicle.vehicle_number,
					vehicle_name: 'Maruti Suzuki Swift'
				})
	end
end
