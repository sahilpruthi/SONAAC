class Station < ApplicationRecord

  has_many :bus_stations
  has_many :vehicles, through: :bus_stations
end
