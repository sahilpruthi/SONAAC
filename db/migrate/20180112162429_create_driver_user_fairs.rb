class CreateDriverUserFairs < ActiveRecord::Migration[5.0]
  def change
    create_table :driver_user_fairs do |t|
      t.belongs_to :user, index: :ture
      t.belongs_to :driver, index: :ture
      t.integer :fair_status
      t.integer :price
      t.timestamps
    end
  end
end
