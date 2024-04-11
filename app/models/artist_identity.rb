class ArtistIdentity < ApplicationRecord
  validates :artist_id, presence: true
  validates :identity_id, presence: true
  validates_uniqueness_of :identity_id, scope: :artist_id

  belongs_to :artist
  belongs_to :identity

end