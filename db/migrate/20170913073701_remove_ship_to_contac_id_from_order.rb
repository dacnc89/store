class RemoveShipToContacIdFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :ship_to_contact_id, :integer
  end
end
