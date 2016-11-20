class PurchaseName < ApplicationRecord
  validates_uniqueness_of :text
  belongs_to :user
  has_many :purchases, dependent: :destroy
end
