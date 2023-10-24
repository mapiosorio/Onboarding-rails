class User < ApplicationRecord
  validates :name, :surname, :company, presence: true

  validates :name, presence: true
  validates :surname, presence: true
  validates :company, presence: true
  validates :position, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
