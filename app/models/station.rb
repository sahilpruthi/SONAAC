class Station < ApplicationRecord

  has_many :bus_stations, dependent: :destroy
  has_many :vehicles, through: :bus_stations
  validates :name, presence: true
end
