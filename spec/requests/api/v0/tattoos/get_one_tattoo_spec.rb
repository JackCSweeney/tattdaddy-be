require 'rails_helper'

RSpec.describe "Get One Tattoo via GET HTTP Request" do
  before(:each) do
    @artist = create(:artist)

    @tattoo = Tattoo.create!({artist_id: @artist.id, price: 250, time_estimate: 90, image_url: "image/path"})

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'can make get request to endpoint and be returned all info from give tattoo' do
      get "/api/v0/tattoos/#{@tattoo.id}", headers: @headers

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Hash)

      tattoo_data = response_data[:data]

      check_hash_structure(tattoo_data, :id, String)
      check_hash_structure(tattoo_data, :attributes, Hash)
      check_hash_structure(tattoo_data[:attributes], :artist, Hash)

      attributes = tattoo_data[:attributes]

      expect(attributes[:price]).to eq(@tattoo.price)
      expect(attributes[:artist_id]).to eq(@tattoo.artist_id)
      expect(attributes[:time_estimate]).to eq(@tattoo.time_estimate)
      expect(attributes[:image_url]).to eq(@tattoo.image_url)
      expect(attributes[:artist][:scheduling_link]).to eq(@artist.scheduling_link)
    end
  end

  describe '#sad path' do
    it 'responds with the correct error message if the tattoo does not exist' do
      get "/api/v0/tattoos/123123123123"

      expect(response).not_to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :errors, Array)
      expect(response_data[:errors].first).to be_a(Hash)
      check_hash_structure(response_data[:errors].first, :detail, String)
      expect(response_data[:errors].first[:detail]).to eq("Couldn't find Tattoo with 'id'=123123123123")
    end
  end
end