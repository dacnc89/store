class Product < ApplicationRecord
  # For filter products in index page
  scope :category_id, ->(cate_id) {where category_id: cate_id}
  scope :price_from, ->(price) {where("price > ?", price)}
  scope :price_to, ->(price) {where("price < ?", price) }

  belongs_to :company
  belongs_to :category
  belongs_to :brand
  has_many   :order_items
  has_many   :order, through: :order_items

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :category_id, presence: true

  #def to_param      # Overwrite to_param for url with name
  #  name
  #end


  def self.filter(filter_params)
    result = self.where(nil)
    filter_params.each do |key,value|
      result = result.public_send(key,value) if value.present?
    end
    result
  end



  # for will_paginate gem
  self.per_page = 20
  WillPaginate.per_page = 20

  def playname
    name.split("-").join(" ")
  end

  def self.search(search_params)
    if search_params && search_params != ""
      #where('name ILIKE ?', "%#{search_params}%")
      where("lower(name) LIKE lower(?) OR lower(description) LIKE lower(?)", "%#{search_params}%", "%#{search_params}%")
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
