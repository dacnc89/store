class RemoveBillToContactIdFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :bill_to_contact_id, :integer
  end
end
