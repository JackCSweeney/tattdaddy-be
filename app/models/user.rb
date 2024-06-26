class User < ApplicationRecord
  has_many :user_tattoos, dependent: :destroy
  has_many :user_identities, dependent: :destroy
  has_many :identities, through: :user_identities
  has_many :tattoos, through: :user_tattoos

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :location, presence: true
  validates :search_radius, presence: true
  validates_presence_of :password, on: :create

  has_secure_password

  def find_user_tatts
    tattoos.where("status = 0")
  end

  def find_user_identities
    identities
  end
end