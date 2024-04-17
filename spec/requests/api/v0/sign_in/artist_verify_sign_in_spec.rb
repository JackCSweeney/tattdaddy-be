require 'rails_helper'

RSpec.describe "Verify User Info for Sign In via HTTP Request" do
  before(:each) do
    @artist = create(:artist, password: "Test")

    @params_1 = {
        email: @artist.email,
        password: "Test",
        type: "Sign In as Artist"
    }

    @params_2 = {
        email: @artist.email,
        password: "WrongPassword",
        type: "Sign In as Artist"
    }

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'can verify a users login credentials and return the user data with correct status' do
      post "/api/v0/sign_in", headers: @headers, params: JSON.generate(@params_1)

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :id, Integer)
      check_hash_structure(response_data[:data], :type, String)
      expect(response_data[:data][:id]).to eq(@artist.id)
      expect(response_data[:data][:type]).to eq("artist")
    end
  end

  describe '#sad path' do
    it 'returns a 422 response when sent invalid data' do
      post "/api/v0/sign_in", headers: @headers, params: JSON.generate(@params_2)

      expect(response).not_to be_successful
      expect(response.status).to eq(422)
    end
  end
end