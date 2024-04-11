require "rails_helper"

RSpec.describe ArtistIdentity, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:artist_id) }
    it { should validate_presence_of(:identity_id) }
  end

  describe "relationships" do
    it {should belong_to :artist}
    it {should belong_to :identity}
  end
end