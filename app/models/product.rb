class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :provider
  belongs_to :category
  has_and_belongs_to_many :additionals
  has_many :orders, dependent: :destroy

  validates :name, :price, :provider, :category, :rating, presence: true
  validates :price, numericality: { greater_than: 0 }
end
