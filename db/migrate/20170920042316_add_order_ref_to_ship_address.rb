class AddOrderRefToShipAddress < ActiveRecord::Migration[5.1]
  def change
    add_reference :ship_addresses, :order, index: true
  end
end
