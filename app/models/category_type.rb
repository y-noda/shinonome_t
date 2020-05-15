class CategoryType < ApplicationRecord
  validates :title, presence: true

  has_many :categories
end
