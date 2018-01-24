module PushNotification

	require 'fcm'
	def self.send_notification(device_keys, user, slat, slong, dlat, dlong)
		fcm = FCM.new(ENV['fcm_key'])
		registration_ids = device_keys
		options = {
      priority: 'high',
      collapse_key: 'updated_score',
      data: {
        message: "#{user.full_name} , need a lift",
        user_id: user.id,
        source_lat: slat,
        source_long: slong,
        destination_lat: dlat,
        destination_long: dlong
      },
      notification: {
        title: 'SONAAC',
        body: "#{user.full_name} , need a lift"     
      }
		}
	  fcm.send(registration_ids, options)
	end

  def self.send_user_notidication(device_key, driver)
    fcm = FCM.new(ENV['fcm_key'])
    vehicle = driver.vehicle_drivers.last.vehicle
    registration_ids = [device_key] 
    options = {
      priority: 'high',
      collapse_key: 'updated_score',
      data: {
        title: 'SONAAC',
        driver_id: driver.id,
        vehicle_number: vehicle.vehicle_number,
        vehicle_name: 'Maruti Suzuki Swift',
        message: "#{driver.name}, offer's lift"
      },
      notification: {
        title: 'SONAAC',
        body: "#{driver.name}, offer's lift"
      }
    }
    fcm.send(registration_ids, options)
  end

end
