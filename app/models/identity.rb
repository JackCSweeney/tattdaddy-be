class Identity < ApplicationRecord
  validates :identity_label, presence: true

  has_many :artist_identities
  has_many :user_identities

end