class CreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :aadhar_number
      t.integer :dl_number
      t.string :dl_image
      t.string :permanenet_address
      t.string :temprorary_address
      t.integer :car_number
      t.integer :car_registration_number

      t.timestamps
    end
  end
end
