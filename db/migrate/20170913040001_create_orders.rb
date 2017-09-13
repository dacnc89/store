class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.integer :ship_address_id
      t.float :fee_amount

      t.timestamps
    end
  end
end
