class Vehicle < ApplicationRecord
  before_create :assign_unique_vehicle_number

  has_many :vehicle_drivers  
  has_many :drivers, through: :vehicle_drivers

  enum vehicle_type: %i(fourwheeler_local sevenwheeler_local
   fourwheeler_outstation sevenwheeler_outstation traveller bus)

  validates :vehicle_type, :model_no, :registration_no, :vehicle_number, presence: true
  validates :registration_no, :vehicle_number, uniqueness: true

  CASE_NUMBER_RANGE = (0000..9999)
  def assign_unique_vehicle_number
  	self.vehicle_unique_number = loop do
    	number = rand(CASE_NUMBER_RANGE)
    	break number unless Vehicle.exists?(vehicle_unique_number: number)
  	end
  end
end
