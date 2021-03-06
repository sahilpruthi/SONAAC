class Vehicle < ApplicationRecord
  before_create :assign_unique_vehicle_number

  has_many :vehicle_drivers
  has_many :drivers, through: :vehicle_drivers
  has_many :bus_stations, dependent: :destroy
  has_many :stations, through: :bus_stations, dependent: :destroy

	enum vehicle_type: %i(fourwheeler_local fourwheeler_outstation sevenwheeler_local sevenwheeler_outstations traveller bus_local bus_outstation)

  validates :vehicle_type, :registration_no, :model_no, :vehicle_number, presence: true
	validates :registration_no, :vehicle_number, uniqueness: true

  CASE_NUMBER_RANGE = (1000..9999)
  def assign_unique_vehicle_number
  	self.vehicle_unique_number = loop do
    	number = rand(CASE_NUMBER_RANGE)
    	break number unless Vehicle.exists?(vehicle_unique_number: number)
  	end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.sheet('Sheet1').row(1)
    (2..spreadsheet.last_row).each do |i|
    # (2..1518).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      begin
        if row.dig('name(station_name)') != nil
          arrival_time = row.dig('arrival_time') == nil ?  row.dig('departure_time') : row.dig('arrival_time')
          departure_time = row.dig('departure_time') == nil ?  row.dig('arrival_time') : row.dig('departure_time')
          station = Station.find_or_create_by(name: row.dig('name(station_name)'))
          vehicle = ''
          if row.dig('model_no').present?
            model_no = row.dig('model_no')
            registration_no = row.dig('registration_no')
            vehicle_number = row.dig('vehicle_number') + '@'+ registration_no.split('@')[1].to_s
              vehicle = Vehicle.create!(model_no: model_no,
               registration_no: registration_no, vehicle_type: row.dig('vehicle_type'),
               vehicle_number: vehicle_number, name: row.dig('name(vehicle_name)'),
                bus_type: row.dig('bus_type'), service_no: row.dig('Service No'))
              bus_station  = vehicle.bus_stations.new(is_source: row.dig('is_source'),        
                is_destination: row.dig('is_destination'), arrival_time: arrival_time,
                 departure_time: departure_time, sequence: row.dig('sequence'),
                  station_id: station.id, price: row.dig('Fare'), duration:row.dig('Duration'))
              bus_station.save!
          else
            bus_station  = Vehicle.last.bus_stations.new(is_source: row.dig('is_source'),
                is_destination: row.dig('is_destination'), arrival_time: arrival_time,
                 departure_time: departure_time, sequence: row.dig('sequence'), station_id: station.id,
                 price: row.dig('Fare'), duration:row.dig('Duration') )
            bus_station.save!
          end
        end
      rescue => error
        Vehicle.last.destroy
        error_message = error.message
        return error.message + " at line " + i.to_s
      end  
    end
  end
end
