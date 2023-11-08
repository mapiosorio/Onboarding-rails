class User < ApplicationRecord
  has_one_attached :photo

  validates_presence_of :name, :surname, :company, :position
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
