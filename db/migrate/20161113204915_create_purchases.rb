class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :category, foreign_key: true
      t.money :price

      t.timestamps
    end
  end
end
