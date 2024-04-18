require "rails_helper"

RSpec.describe "endpoint patch api/v0/artists/:id" do
  describe "As a user" do

    before do
      @headers = {
        "CONTENT_TYPE": "application/json",
        "ACCEPT": "application/json"
      }

      create_list(:artist, 5)
      @artist = create(:artist, name: "Change Me")
    end

    it "can update a artist from the database via HTTP request" do
      expect(@artist.name).to eq("Change Me")

      artist_params = {
        name: "Ted Lasso",
        location: "Pacific Ocean",
        email: "[tatart@gmail.com](mailto:tatart@gmail.com)",
        password: "FakerPassowrd1",
        scheduling_link: "https://www.the_best_website_ever.com"
      }

      patch "/api/v0/artists/#{@artist.id}", params: JSON.generate({ artist: artist_params }), headers: @headers
      
      artist = JSON.parse(response.body, symbolize_names: true)[:data]
      check_hash_structure(artist, :id, String)
      check_hash_structure(artist, :attributes, Hash)
      expect(artist[:attributes][:name]).to eq("Ted Lasso")
      check_hash_structure(artist[:attributes], :location, String)
      check_hash_structure(artist[:attributes], :email, String)
      check_hash_structure(artist[:attributes], :scheduling_link, String)
    end

    describe "sad path" do 
      xit "errors when not all atrributes are filled in" do 
        artist_params = {
          name: "",
          location: "Pacific Ocean",
          email: "",
          password: "FakerPassowrd1",
          scheduling_link: ""
        }

        patch "/api/v0/artists/#{@artist.id}", params: JSON.generate({ artist: artist_params }), headers: @headers
        data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        
        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Validation failed: Name can't be blank, Email can't be blank, Scheduling link can't be blank")
      end

      it "errors on an invalid id" do 
        id = 22222

        artist_params = {
        name: "Ted Lasso",
        location: "Pacific Ocean",
        email: "[tatart@gmail.com](mailto:tatart@gmail.com)",
        password: "FakerPassowrd1",
        scheduling_link: "https://www.the_best_website_ever.com"
      }

        patch "/api/v0/artists/#{id}", params: JSON.generate({ artist: artist_params }), headers: @headers
        data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        
        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Artist with 'id'=22222")
      end
    end
  end 
end