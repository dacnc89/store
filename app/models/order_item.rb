class OrderItem < ApplicationRecord
  belongs_to  :order, optional: true
  belongs_to  :cart
  belongs_to  :product

  def price_line
    product.price*quantity
  end

end
