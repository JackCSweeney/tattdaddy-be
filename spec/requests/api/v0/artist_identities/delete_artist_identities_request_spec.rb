require "rails_helper"

RSpec.describe "endpoint delete /api/v0/artist_identities" do
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

      @artist_identity = ArtistIdentity.create!(@params)
    end

    it "deletes a artist identity relation via HTTP request" do
      delete "/api/v0/user_tattoos", params: JSON.generate(artist_identity: @params), headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end 
end