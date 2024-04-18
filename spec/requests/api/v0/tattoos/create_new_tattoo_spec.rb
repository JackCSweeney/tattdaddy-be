require 'rails_helper'

RSpec.describe 'Create New Tattoo via POST HTTP Request' do
  before(:each) do
    @artist = create(:artist)

    @params = {price: 90, time_estimate: 120, artist_id: @artist.id, image_url: "test/url/path"}
    @bad_params = {price: 90, time_estimate: 120, artist_id: @artist.id}
    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'can create a new tattoo record with all attributes via post http request' do
      post "/api/v0/tattoos", headers: @headers, params: JSON.generate(@params)

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :id, String)
      attributes = response_data[:data][:attributes]

      expect(attributes[:image_url]).to eq(@params[:image_url])
      expect(attributes[:price]).to eq(@params[:price])
      expect(attributes[:time_estimate]).to eq(@params[:time_estimate])
      expect(attributes[:artist_id]).to eq(@params[:artist_id])
    end
  end

  describe '#sad path' do
    it 'returns the correct resopnse when uploading a tattoo with incorrect parameters' do
      post "/api/v0/tattoos", headers: @headers, params: JSON.generate(@bad_params)

      expect(response).not_to be_successful

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to have_key(:errors)
      expect(error[:errors].first[:detail]).to eq("Validation failed: Image url can't be blank")
    end
  end
end