class CreateBusStations < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_stations do |t|
			t.boolean :is_source
  		t.boolean :is_destination
  		t.integer :sequence
  		t.string :arrival_time
  		t.string :departure_time
      t.integer :price
      t.datetime :duration
  		t.belongs_to :vehicle, index: true
  		t.belongs_to :station, index: true
      t.timestamps
    end
  end
end
