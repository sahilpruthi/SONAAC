class Driver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :dl_image, DriverUploader

  RANDOM_HASH = {
    0 => 99..999,
    10 => 10..99,
    100 => 0..9
  }
end
