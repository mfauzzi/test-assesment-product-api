class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # Validations
  validates :name, :price, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
