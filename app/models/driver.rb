class Driver < ApplicationRecord
  includes PushNotification
  before_create :assign_unique_driver_number

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :dl_number, uniqueness: true
  validates :aadhar_number, uniqueness: true
  validates :driver_unique_number, uniqueness: :ture

  mount_uploader :dl_image, DriverUploader

  reverse_geocoded_by :latitude, :longitude

  has_many :driver_user_fairs
  has_many :users, through: :driver_user_fairs
  has_many :vehicle_drivers
  has_many :vehicles, through: :vehicle_drivers

private

	CASE_NUMBER_RANGE = (1000..9999)

	def assign_unique_driver_number
	  	self.driver_unique_number = loop do
	    	number = rand(CASE_NUMBER_RANGE)
	    	break number unless Driver.exists?(driver_unique_number: number)
	  	end
	end

  def self.send_notification(device_keys, user, slat, slong, dlat, dlong)
    PushNotification.send_notification(device_keys, user, slat, slong, dlat, dlong)
  end
end
