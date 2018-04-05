class AddColumnBlockToUserDriverVehicle < ActiveRecord::Migration[5.0]
  def change

  	add_column :users, :is_block, :boolean, default: false, null: false
  	add_column :vehicles, :is_block, :boolean, default: false, null: false
  	add_column :drivers, :is_block, :boolean, default: false, null: false
  end
end
