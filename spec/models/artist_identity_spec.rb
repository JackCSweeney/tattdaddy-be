require "rails_helper"

RSpec.describe ArtistIdentity, type: :model do
  describe "relationships" do
    it {should belong_to :artist}
    it {should belong_to :identity}
  end
end