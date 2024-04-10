require "rails_helper"

RSpec.describe "end point get /api/v0/artists/:id/tattoos" do
  describe "As a User" do

    before do
      @artist = create(:artist)
      @artist_2 = create(:artist)

      @tattoo_1 = create(:tattoo, artist_id: @artist.id)
      @tattoo_2 = create(:tattoo, artist_id: @artist.id)
      @tattoo_3 = create(:tattoo, artist_id: @artist.id)
      @tattoo_4 = create(:tattoo, artist_id: @artist_2.id)
    end

    it "can get all tattoos from a specific artist from the database via HTTP request" do
      get "/api/v0/artists/#{@artist.id}/tattoos"

      expect(response).to be_successful

      tattoos = JSON.parse(response.body, symbolize_names: true)
      
      expect(tattoos[:data].count).to eq(3)
     
      tattoos[:data].each do |tattoo|
        check_hash_structure(tattoo, :id, String)
        check_hash_structure(tattoo, :attributes, Hash)
        check_hash_structure(tattoo[:attributes], :price, Integer)
        check_hash_structure(tattoo[:attributes], :time_estimate, Integer)
        check_hash_structure(tattoo[:attributes], :artist_id, Integer)
        check_hash_structure(tattoo[:attributes], :image_url, String)
      end 
    end

    describe "sad path" do 
      it "sends error response when invalid id is entered" do 
        id = 22222

        get "/api/v0/artists/#{id}/tattoos"

        expect(response).to_not be_successful

        expect(response.status).to eq(404)
    
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Artist with 'id'=22222")
      end
    end
  end 
end