class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :provider
  belongs_to :category

  validates_presence_of :name, :price, :provider, :category, :rating
end
