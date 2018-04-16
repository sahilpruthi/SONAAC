class BusStation < ApplicationRecord
	belongs_to :vehicle
	belongs_to :station
	validates  :sequence, :arrival_time, :departure_time,
	:vehicle_id, presence: true
end
