class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :price
  has_one :category
  has_one :purchase_name
end
