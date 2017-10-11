class CreateShipAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :ship_addresses do |t|
      t.string :name
      t.string :city
      t.string :district
      t.string :ward
      t.string :details

      t.timestamps
    end
  end
end
