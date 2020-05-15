class SelfCheck < ApplicationRecord 
  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :category, presence: true
  validates :answer, presence: true
end
