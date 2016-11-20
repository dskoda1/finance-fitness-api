class Purchase < ApplicationRecord
  belongs_to :category
  belongs_to :purchase_name
end
