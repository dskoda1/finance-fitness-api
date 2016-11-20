class CreatePurchaseNames < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_names do |t|
      t.string :text
      t.timestamps
    end
  end
end
