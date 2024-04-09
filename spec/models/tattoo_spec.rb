require 'rails_helper'

RSpec.describe Tattoo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:time_estimate) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:artist_id) }
    it { should validate_numericality_of(:price) }
    it { should validate_numericality_of(:time_estimate) }
  end

  describe 'relationships' do
    it { should belong_to :artist }
    it { should have_many :user_tattoos }
  end
end