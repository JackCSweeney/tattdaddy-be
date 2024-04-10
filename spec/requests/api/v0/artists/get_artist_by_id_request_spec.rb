require "rails_helper"

RSpec.describe "endpoint get api/v0/artists/:id" do
  describe "As a User" do
    before do
      create_list(:artist, 5)
      @artist = create(:artist)
    end

    it "can get a artist from the database via HTTP request" do
      get api_v0_artist_path(@artist.id)

      expect(response).to be_successful

      artist = JSON.parse(response.body, symbolize_names: true)[:data]
      
      check_hash_structure(artist, :id, String)
      check_hash_structure(artist, :attributes, Hash)
      check_hash_structure(artist[:attributes], :name, String)
      check_hash_structure(artist[:attributes], :location, String)
      check_hash_structure(artist[:attributes], :email, String)
    end

    describe "sad path" do 
      it "sends error response when invalid id is entered" do 
        id = 22222

        get api_v0_artist_path(id)

        expect(response).to_not be_successful

        expect(response.status).to eq(404)
    
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Artist with 'id'=22222")
      end
    end
  end 
end