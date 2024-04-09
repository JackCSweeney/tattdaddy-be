class Identity < ApplicationRecord
  validates :identity_label, presence: true

  belongs_to :artist
  belongs_to :user

end