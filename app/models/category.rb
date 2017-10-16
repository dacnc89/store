class Category < ApplicationRecord
  has_many  :products
  has_many  :subcategories, class_name: "Category", foreign_key: "parent_id"
  belongs_to  :parent,  class_name: "Category", optional: true
  
  def get_parents
    result = []
    if parent_id.nil?
    result.unshift(self)
    else
      result.push(self)
      while parent_id.present?
        parent = Category.find(parent_id)
        self.parent_id = parent.parent_id
        result.unshift(parent)
      end
    end
    #we have id of current category
    # 1. while current category.parent_id.present?
    #   push parent_category into result
    #   change id = parent_category.id
    #   end
    #   meaning parent_id = nil we don't doing anything
    return result
  end


  def all_products
    
  end
end
