class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :price
  has_one :category
end
