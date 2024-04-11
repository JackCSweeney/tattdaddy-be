class UserTattoo < ApplicationRecord
  validates :user_id, presence: true
  validates :tattoo_id, presence: true
  validates_uniqueness_of :tattoo_id, scope: :user_id

  belongs_to :user
  belongs_to :tattoo

  enum status: ["liked", "disliked"]

end