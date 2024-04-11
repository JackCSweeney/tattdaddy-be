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
      delete "/api/v0/artist_identities", params: JSON.generate(artist_identity: @params), headers: @headers
      
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    describe "Sad Path" do 
      it "errors if association does not exist" do 
        delete "/api/v0/artist_identities", params: JSON.generate(artist_identity: @params), headers: @headers

        delete "/api/v0/artist_identities", params: JSON.generate(artist_identity: @params), headers: @headers
        expect(response).not_to be_successful
        expect(response.status).to eq(404)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response).to have_key(:message)
        expect(error_response[:message]).to eq("Association between Identity and Artist does not exist")
      end
    end
  end 
end