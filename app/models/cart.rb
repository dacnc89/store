class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy

  def add_order_item(product_id)
    current_item = order_items.find_by(product_id: product_id)

    if current_item
      current_item.quantity +=1
    else
      current_item = order_items.build(product_id: product_id)
    end
    current_item
  end

  def amount
    amount = 0
    order_items.each do |order_item|
      amount += order_item.product.price * order_item.quantity
    end
    amount
  end

  def pass_order_item_from_cart(order)
     order_items.each do |item|
       order.order_items.push(item)
     end
   end

end
