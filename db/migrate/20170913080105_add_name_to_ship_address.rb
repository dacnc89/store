class AddNameToShipAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :ship_addresses, :name, :string
  end
end
