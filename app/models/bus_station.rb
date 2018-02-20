class BusStation < ApplicationRecord
	belongs_to :vehicle
	belongs_to :station
end
