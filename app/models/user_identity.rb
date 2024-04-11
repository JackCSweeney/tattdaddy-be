class UserIdentity < ApplicationRecord
  belongs_to :user
  belongs_to :identity

  validates :user_id, presence: true
  validates :identity_id, presence: true
  validates_uniqueness_of :identity_id, scope: :user_id
end