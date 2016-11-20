class AddPurchaseNameToPurchases < ActiveRecord::Migration[5.0]
  def change
    remove_column :purchases, :title, :string
    add_column :purchases, :purchase_name_id, :integer
  end
end
