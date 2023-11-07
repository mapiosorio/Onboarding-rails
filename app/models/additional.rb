class Additional < ApplicationRecord
  has_and_belongs_to_many :products
  has_and_belongs_to_many :orders
  validates :price, :description, presence: true
end
