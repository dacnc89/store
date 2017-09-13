class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.float :available_quantity
      t.string :image_file
      t.integer :company_id
      t.integer :category_id
      t.integer :brand_id

      t.timestamps
    end
  end
end
