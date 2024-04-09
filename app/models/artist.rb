class Artist < ApplicationRecord
  has_many :tattoos, dependent: :destroy
  has_many :artist_identities, dependent: :destroy
  has_many :identities, through: :artist_identities

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :location, presence: true
  validates_presence_of :password

  has_secure_password
end