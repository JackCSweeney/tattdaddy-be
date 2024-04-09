class Tattoo < ApplicationRecord
  validates :time_estimate, presence: true, numericality: true
  validates :price, presence: true, numericality: true
  validates :artist_id, presence: true
  validates :image_url, presence: true


  belongs_to :artist
  has_many :user_tattoos

end