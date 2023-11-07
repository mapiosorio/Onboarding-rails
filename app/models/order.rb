class Order < ApplicationRecord
  has_one_attached :company_logo
  belongs_to :user
  belongs_to :product
  has_and_belongs_to_many :additionals

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates_presence_of :total, :subtotal, :taxes, :delivery_date, :delivery_time, :recipient_name, :recipient_phone_number, :rut, :company_name, :delivery_direction, :user, :product, presence: true
end
