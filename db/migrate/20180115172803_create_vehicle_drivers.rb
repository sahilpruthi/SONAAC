class CreateVehicleDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_drivers do |t|
      t.belongs_to :vehicle, index: true
      t.belongs_to :driver, index: true
      t.timestamps
    end
  end
end
