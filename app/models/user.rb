class User < ApplicationRecord
  has_one_attached :photo

  def self.ransackable_attributes(auth_object = nil)
    ["company", "created_at", "email", "encrypted_password", "id", "name", "position", "remember_created_at", "reset_password_sent_at", "reset_password_token", "surname", "updated_at", "photo"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["photo_attachment", "photo_blob"]
  end

  validates_presence_of :name, :surname, :company, :position
  validates :phone_number, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
