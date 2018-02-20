class CreateBusStations < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_stations do |t|
			t.boolean :is_source
  		t.boolean :is_destination	
  		t.integer :sequence
  		t.datetime :arrival_time
  		t.datetime :departure_time
  		t.belongs_to :vehicle, index: true
  		t.belongs_to :station, index: true
      t.timestamps
    end
  end
end
