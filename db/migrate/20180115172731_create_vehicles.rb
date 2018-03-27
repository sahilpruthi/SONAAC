class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :model_no
      t.string :registration_no, null: false
      t.integer :vehicle_type, null: false
      t.string :vehicle_number, null: false
      t.string :bus_type
      t.string :name
      t.string :vehicle_unique_number
      t.integer :service_no
      t.timestamps
    end
  end
end
