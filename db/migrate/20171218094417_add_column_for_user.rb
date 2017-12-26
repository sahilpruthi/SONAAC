class AddColumnForUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_name, :string
    add_column :users, :phone_number, :integer, limit: 10
    add_column :users, :emergency_number, :integer
  end
end
