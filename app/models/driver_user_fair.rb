class DriverUserFair < ApplicationRecord
	belongs_to :driver
	belongs_to :user

	enum fair_status: %i(offered confirmed started completed cancelled)
end
