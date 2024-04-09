class Tattoo < ApplicationRecord
  validates :time_estimate, presence: true
  validates :price, presence: true, numericality: true
  validates :artist_id, presence: true


  belongs_to :artist
  has_many :users, dependent: :destroy

end