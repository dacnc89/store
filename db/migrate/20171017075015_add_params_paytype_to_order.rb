class AddParamsPaytypeToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :paytype, :string
  end
end
