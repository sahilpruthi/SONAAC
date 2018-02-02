class AddColumnForUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone_number, :bigint
    add_column :users, :emergency_number, :bigint
    add_column :users, :token, :string
    add_column :users, :full_name, :string
    add_column :users, :latitude,  :float
    add_column :users, :longitude, :float
    add_column :users, :social_media, :string
    add_column :users, :social_id, :string
    add_column :users, :fcm_token, :string
    add_column :users,  :type, :string
  end
end
