class Category < ApplicationRecord
  has_many :categorizations
  has_many :posts, through: :categorizations

  validates :name, presence: true, uniqueness: true
end
