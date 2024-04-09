class UserTattoo < ApplicationRecord
  validates :user_id, presence: true
  validates :tattoo_id, presence: true

  belongs_to :user
  belongs_to :tattoo

end