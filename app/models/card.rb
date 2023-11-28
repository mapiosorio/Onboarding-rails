class Card < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates_presence_of :number, :expiration_date, :cardholder, :cvv
  validates :cvv, length: { is: 3 }
  validates :number, length: { is: 16 }
end
