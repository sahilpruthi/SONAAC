class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :driver_user_fairs
  has_many :drivers, through: :driver_user_fairs

  def self.send_notification(device_key, driver)
    PushNotification.send_user_notidication(device_key, driver)
  end

end
