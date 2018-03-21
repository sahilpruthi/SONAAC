namespace :import do
  desc "Import Csv file for bus data"
  task bus_data: :environment do
  	 # Vehicle.create(model_no: 'sdf', registration_no: 'sadf', vehicle_type: 'bus', vehicle_number: 'not-mentioned', name: 'Bus')
  	  spreadsheet = Roo::Spreadsheet.open("vendor/Sonaac data sharing.xlsx")
	  header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      station = Station.find_or_create_by(name: row.dig('name(station_name)'))
      begin
        arrival_time =  DateTime.strptime(row.dig('arrival_time').to_s,'%s').strftime('%I:%M:%S %p')
        departure_time =  DateTime.strptime(row.dig('departure_time').to_s,'%s').strftime('%I:%M:%S %p')
      rescue => error
        binding.pry
      end
      unless arrival_time.present? || departure_time.present?
        binding.pry
      end

      if row.dig('model_no').present?
        model_no = row.dig('model_no') == 'Not-available' ? row.dig('model_no')+ i.to_s : row.dig('model_no')
        registration_no = row.dig('registration_no') == 'Not-available' ? row.dig('registration_no') +i.to_s : row.dig('registration_no')
        vehicle_number = row.dig('vehicle_number') == 'Not-available' ? row.dig('vehicle_number') + i.to_s : row.dig('vehicle_number')
        vehicle_number = Vehicle.find_by(vehicle_number: vehicle_number).present? ? vehicle_number + '@' + i.to_s : vehicle_number
	  		vehicle = Vehicle.create(model_no: model_no,
	  		 registration_no: registration_no, vehicle_type:  row.dig('vehicle_type'),
	  		 vehicle_number: vehicle_number, name: row.dig('name(vehicle_name)'), bus_type: row.dig('bus_type'))
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
	  	bus_station.save
	  	end
	  end

  end

end
