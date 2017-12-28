class Driver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :assign_unique_driver_number


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, uniqueness: true
  validates :driver_unique_number, uniqueness: :ture


private
	CASE_NUMBER_RANGE = (0000..9999)

	def assign_unique_driver_number
	  	self.driver_unique_number = loop do
	    	number = rand(CASE_NUMBER_RANGE)
	    	break number unless Driver.exists?(driver_unique_number: number)
	  	end
	end
end
