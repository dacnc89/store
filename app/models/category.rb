class Category < ApplicationRecord
  has_many  :products
  has_many  :subcategories, class_name: "Category", foreign_key: "parent_id"
  belongs_to  :parent,  class_name: "Category", optional: true
  

  def get_parents
    result = [id]
    if parent_id  == nil
      result
    else
      category = Category.find(id)
      while category.parent_id != nil do
        result.push category.parent.id
        category = category.parent
      end
    end
    result = result.reverse
  end
end
