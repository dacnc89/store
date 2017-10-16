class Product < ApplicationRecord
  belongs_to :company
  belongs_to :category
  belongs_to :brand
  has_many   :order_items
  has_many   :order, through: :order_items

  # for will_paginate gem
  self.per_page = 20
  WillPaginate.per_page = 20

  def playname
    name.split("-").join(" ")
  end

  def self.search(search_params)
    
    if search_params && search_params != ""
      #where('name ILIKE ?', "%#{search_params}%")
      where("lower(name) LIKE lower(?)", "%#{search_params}%")
    else
      order('created_at ASC')
    end
  end


  def get_category
    category = Category.find(category_id)
    parent_list = [category]
    while category.parent_id.present?
      parent = Category.find(category.parent_id)
      category = parent
      parent_list.push(parent)
    end
    return parent_list
  end
end
