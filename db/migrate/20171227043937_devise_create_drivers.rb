class DeviseCreateDrivers < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.string :aadhar_number
      t.string :dl_number
      t.string :dl_image
      t.string :permanenet_address
      t.string :temprorary_address
      t.string :driver_unique_number
      t.string :token
      t.float  :latitude
      t.float  :longitude
      t.string :fcm_token
      t.string :phone_number
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :drivers, :email,                unique: true
    add_index :drivers, :reset_password_token, unique: true
    # add_index :drivers, :confirmation_token,   unique: true
    # add_index :drivers, :unlock_token,         unique: true
  end
end
