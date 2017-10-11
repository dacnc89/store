class Product < ApplicationRecord
  belongs_to :company
  belongs_to :category
  belongs_to :brand
  has_many   :order_items
  has_many   :order, through: :order_items


  def playname
    name.split("-").join(" ")
  end

  def self.search(search_params)
    if search_params && search_params != ""
    where("name LIKE ?", "%#{search_params}%")
    else
      order('created_at ASC')
    end
  end
end
