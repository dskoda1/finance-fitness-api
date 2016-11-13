class CategoryResource < JSONAPI::Resource
  has_one :user
  attributes :name
end
