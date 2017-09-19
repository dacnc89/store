class AddRefToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :cart, foreign_key: true
  end
end
