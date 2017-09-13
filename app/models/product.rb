class Product < ApplicationRecord
  belongs_to :company
  belongs_to :category
  belongs_to :brand
  has_many   :order_items
  has_many   :order, through: :order_items
end
