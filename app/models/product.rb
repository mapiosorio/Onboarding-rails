class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :provider
  belongs_to :category
  has_and_belongs_to_many :additionals

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "finger_food", "gluten_free", "id", "name", "price", "rating", "sharing", "sugar_free", "provider_id", "updated_at", "vegan"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "provider", "additionals", "image_attachment", "image_blob"]
  end

  validates :name, :price, :provider, :category, :rating, presence: true
end
