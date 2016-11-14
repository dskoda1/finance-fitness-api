class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  has_many :categories, dependent: :destroy

  def default_categories
    return  [
      [ "Food" ],
      [ "Entertainment" ],
      [ "Bills" ],
      [ "Transportation" ]
    ]
  end
  after_create do
    categories = default_categories
    categories.each { |category|
      Category.create(name: category[0], user_id: id)
    }
  end
end
