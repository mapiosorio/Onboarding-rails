class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :provider
  belongs_to :category
  has_and_belongs_to_many :additionals

  validates_presence_of :name, :price, :provider, :category, :rating
end
