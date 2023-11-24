class User < ApplicationRecord
  before_destroy :disassociate_orders

  has_one_attached :photo
  has_many :orders
  has_many :cards, dependent: :destroy

  validates_presence_of :name, :surname, :company, :position
  validates :phone_number, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def disassociate_orders
    orders.update_all(user_id: nil, card_id: nil)
  end
end
