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
        type: 'need_lift_notification',
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
    registration_ids = [device_key] 
    options = {
      priority: 'high',
      collapse_key: 'updated_score',
      data: {
        title: 'SONAAC',
        driver_id: driver.id,
        driver_unique_id: driver.driver_unique_number,
        vehicle_unique_id:  driver.vehicles.last.vehicle_unique_number,
        type: 'offer_lift_notification',
        message: "#{driver.name}, offer's lift"
      },
      notification: {
        title: 'SONAAC',
        body: "#{driver.name}, offer's lift"
      }
    }
    fcm.send(registration_ids, options)
  end

  def self.cancel_notification(device_key, user, fair)
    fcm = FCM.new(ENV['fcm_key'])
    registration_ids = [device_key] 
    options = {
      priority: 'high',
      collapse_key: 'updated_score',
      data: {
        title: 'SONAAC',
        user_id: user.id,
        fair_id: fair.id,
        type: 'cancel_notification',
        message: "#{user.full_name}, cancel his lift"
      },
      notification: {
        title: 'SONAAC',
        body: "#{user.full_name}, cancel lift"
      }
    }
    fcm.send(registration_ids, options)
  end

  def self.stop_notification(device_key)
    fcm = FCM.new(ENV['fcm_key'])
    registration_ids = [device_key] 
    options = {
      priority: 'high',
      collapse_key: 'updated_score',
      data: {
        title: 'SONAAC',
        type: 'stop_notification',
        message: "Trip Cancelled Successfully"
      },
      notification: {
        title: 'SONAAC',
        body: "Trip cancelled"
      }
    }
    fcm.send(registration_ids, options)
  end

   def self.resume_notification(device_key)
    fcm = FCM.new(ENV['fcm_key'])
    registration_ids = [device_key] 
    options = {
      priority: 'high',
      collapse_key: 'updated_score',
      data: {
        title: 'SONAAC',
        type: 'resume_notification',
        message: "Trip Cancellation Declined"
      },
      notification: {
        title: 'SONAAC',
        body: "Trip Cancellation Declined"
      }
    }
    fcm.send(registration_ids, options)
  end

end
