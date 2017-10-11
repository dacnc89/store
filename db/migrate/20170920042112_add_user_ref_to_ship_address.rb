class AddUserRefToShipAddress < ActiveRecord::Migration[5.1]
  def change
    add_reference :ship_addresses, :user, index: true
  end
end
