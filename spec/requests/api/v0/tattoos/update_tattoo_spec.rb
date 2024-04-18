require "rails_helper"

RSpec.describe "endpoint patch api/v0/tattoos/:id" do
  describe "As a user" do

    before do
      @artist = create(:artist)
      @tattoo = Tattoo.create!({artist_id: @artist.id, price: 250, time_estimate: 90, image_url: "image/path"})
      @headers = {"CONTENT_TYPE" => "application/json"}
    end

    it "can update a tattoo from the database via HTTP request" do
      expect(@tattoo.price).to eq(250)
      expect(@tattoo.time_estimate).to eq(90)

      tattoo_params = {
        price: 300, 
        time_estimate: 90, 
        artist_id: @artist.id, 
        image_url: "test/url/path"
      }

      patch "/api/v0/tattoos/#{@tattoo.id}", headers: @headers, params: JSON.generate(tattoo_params)

      tattoo = JSON.parse(response.body, symbolize_names: true)[:data]

      check_hash_structure(tattoo, :id, String)
      check_hash_structure(tattoo, :attributes, Hash)
      expect(tattoo[:attributes][:price]).to eq(300)
      expect(tattoo[:attributes][:time_estimate]).to eq(90)
      check_hash_structure(tattoo[:attributes], :image_url, String)
      check_hash_structure(tattoo[:attributes], :artist_id, Integer)
      check_hash_structure(tattoo[:attributes], :artist, Hash)
      expect(tattoo[:attributes][:artist][:scheduling_link]).to eq(@artist.scheduling_link)
    end

    describe "sad path" do 
      xit "errors if given a blank attribute" do 
        tattoo_params = {
          price: nil, 
          time_estimate: nil, 
          artist_id: @artist.id, 
          image_url: ""
        }

        patch "/api/v0/tattoos/#{@tattoo.id}", params: JSON.generate(tattoo_params), headers: @headers
        data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        
        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Validation failed: Time estimate can't be blank, Time estimate is not a number, Price can't be blank, Price is not a number, Image url can't be blank")
      end

      it "errors on an invalid id" do 
        id = 8675309

        tattoo_params = {
          price: 300, 
          time_estimate: 90, 
          artist_id: 18, 
          image_url: "test/url/path"
        }

        patch "/api/v0/tattoos/#{id}", params: JSON.generate({ tattoo: tattoo_params }), headers: @headers
        data = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        
        expect(data[:errors]).to be_a(Array)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Tattoo with 'id'=8675309")
      end
    end
  end 
end