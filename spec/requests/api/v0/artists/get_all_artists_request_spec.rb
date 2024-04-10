require "rails_helper"

RSpec.describe "endpoint get /api/v0/artists" do
  describe "As a user" do

    before do
      create_list(:artist, 5)
    end

    it "gets all artists from the database via HTTP request " do
      get "/api/v0/artists"

      expect(response).to be_successful

      artists = JSON.parse(response.body, symbolize_names: true)
      
      expect(artists[:data].count).to eq(5)

      artists[:data].each do |artist|
        check_hash_structure(artist, :id, String)
        check_hash_structure(artist, :attributes, Hash)
        check_hash_structure(artist[:attributes], :name, String)
        check_hash_structure(artist[:attributes], :location, String)
        check_hash_structure(artist[:attributes], :email, String)
      end
    end
  end 
end