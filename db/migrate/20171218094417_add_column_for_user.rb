class AddColumnForUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_name, :string
    add_column :users, :phone_number, :bigint
    add_column :users, :emergency_number, :bigint
    add_column :users, :token, :string
    add_column :users, :full_name, :string
  end
end
