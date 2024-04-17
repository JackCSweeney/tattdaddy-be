class UserTattoo < ApplicationRecord
  validates :user_id, presence: true
  validates :tattoo_id, presence: true
  validates_uniqueness_of :tattoo_id, scope: :user_id

  belongs_to :user
  belongs_to :tattoo

  enum status: ["liked", "disliked"]

  def self.delete_disliked_tattoos(user_id)
    disliked = self.where("status = 1 AND user_id = #{user_id}")
    disliked.each do |user_tattoo|
      user_tattoo.delete
    end
  end

end