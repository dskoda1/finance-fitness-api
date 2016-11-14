class AddTitle < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :title, :string
  end
end
