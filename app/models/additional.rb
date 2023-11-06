class Additional < ApplicationRecord
  has_and_belongs_to_many :products

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "price", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end

  validates :price, :description, presence: true
end
