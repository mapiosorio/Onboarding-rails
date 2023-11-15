class Additional < ApplicationRecord
  has_and_belongs_to_many :products

  validates :price, :description, presence: true
end
