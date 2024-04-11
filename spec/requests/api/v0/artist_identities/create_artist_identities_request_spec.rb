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

      @bad_params = {
        artist_id: @artist.id,
        identity_id: 55555
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

    describe "Sad Path" do 
      it "sends an error when a relation between Artist and Identity already exists" do 
        post "/api/v0/artist_identities", params: JSON.generate(artist_identity: @params), headers: @headers
        
        post "/api/v0/artist_identities", params: JSON.generate(artist_identity: @params), headers: @headers
        
        expect(response).not_to be_successful
        expect(response.status).to eq(422)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response).to have_key(:errors)
        expect(error_response[:errors]).to be_a(Array)

        expect(error_response[:errors].first).to have_key(:detail)
        expect(error_response[:errors].first[:detail]).to eq("Validation failed: Identity has already been taken")
      end

      it "errors with an invalid" do 
        post "/api/v0/artist_identities", params: JSON.generate(artist_identity: @bad_params), headers: @headers
        
        expect(response).to_not be_successful

        expect(response.status).to eq(404)
    
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Validation failed: Identity must exist")
      end 
    end
  end 
end