class Category < ApplicationRecord
  validates_uniqueness_of :name
  belongs_to :user
end
