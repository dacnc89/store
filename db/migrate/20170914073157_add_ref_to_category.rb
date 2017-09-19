class AddRefToCategory < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :parent
  end
end
