require "rails_helper"

RSpec.describe "endpoint post /api/v0/artist_identities" do
  describe "As a User" do

    before do
      @artist = create(:artist)
      @identity = Identity.create!({identity_label: "Female"})

      @params = {
        artist_id: @artist.id,
        identity_id: @identity.id
      }

      @headers = {
        "CONTENT_TYPE": "application/json",
        "ACCEPT": "application/json"
      }
    end

    it "creates an artist identity association via HTTP request" do
      post "/api/v0/artist_identities", params: JSON.generate(artist_identity: @params), headers: @headers

      new_artist_identity = ArtistIdentity.last 

      expect(new_artist_identity.artist_id).to eq(@artist.id)
      expect(new_artist_identity.identity_id).to eq(@identity.id)
      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to eq({:message => "Identity successfully added to Artist"})
    end
  end 
end