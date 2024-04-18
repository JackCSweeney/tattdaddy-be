require "rails_helper"

RSpec.describe "endpoint post api/v0/artists" do
  describe "As a User" do

    before do
      @headers = {
        "CONTENT_TYPE": "application/json",
        "ACCEPT": "application/json"
      }

      create_list(:artist, 5)
    end

    it "can create a artist from the database via HTTP request" do
      expect(Artist.all.count).to eq(5)

      artist_params = {
        name: "Ted Lasso",
        location: "Pacific Ocean",
        email: "[tatart@gmail.com](mailto:tatart@gmail.com)",
        password: "FakerPassowrd1",
        scheduling_link: "http://www.website.com"
      }

      post "/api/v0/artists", params: JSON.generate({ artist: artist_params }), headers: @headers
      artist = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(Artist.all.count).to eq(6)
      check_hash_structure(artist, :id, String)
      check_hash_structure(artist, :attributes, Hash)
      check_hash_structure(artist[:attributes], :name, String)
      check_hash_structure(artist[:attributes], :location, String)
      check_hash_structure(artist[:attributes], :email, String)
      check_hash_structure(artist[:attributes], :scheduling_link, String)
    end

    describe "sad path" do 
      it "errors when not all atrributes are filled in" do 
        artist_params = {
          name: "",
          location: "Pacific Ocean",
          email: "",
          password: "FakerPassowrd1",
          scheduling_link: ""
        }

        post "/api/v0/artists", params: JSON.generate({ artist: artist_params }), headers: @headers
        data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Validation failed: Name can't be blank, Email can't be blank, Scheduling link can't be blank")
      end
    end
  end 
end