class CreateShipAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :ship_addresses do |t|
      t.text :address1
      t.text :address2
      t.string :city
      t.integer :phone_number
      t.boolean :default, default: false
      t.belongs_to :users
      t.belongs_to :order

      t.timestamps
    end
  end
end
