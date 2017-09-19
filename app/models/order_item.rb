class OrderItem < ApplicationRecord
  belongs_to  :order, optional: true
  belongs_to  :cart, dependent: :destroy
  belongs_to  :product

  def price_line
    product.price*quantity
  end

end
