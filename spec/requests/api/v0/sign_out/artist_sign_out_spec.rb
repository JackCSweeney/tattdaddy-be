require 'rails_helper'

RSpec.describe "Sign Artist Out via DELETE HTTP Request" do
  before(:each) do
    @artist = create(:artist)

    @headers = {"CONTENT_TYPE" => "application/json"}

    @sign_in_params = {
      sign_in: {
        email: @artist.email,
        password: "Test",
        type: "Sign In as Artist"
      },
      controller: "sessions",
      action: "create"
    }
    @sign_out_params = {artist_id: @artist.id}
    @bad_params = {}

    post "/api/v0/sign_in", headers: @headers, params: JSON.generate(@sign_in_params)
  end

  describe '#happy path' do
    it 'returns the correct status when sent valid parameters for signing out an artist' do
      delete "/api/v0/sign_out", headers: @headers, params: JSON.generate(@sign_out_params)

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end

  describe '#sad path' do
    it 'returns the correct status when sent invalid parameters for signing out an artist' do
      delete "/api/v0/sign_out", headers: @headers, params: JSON.generate(@bad_params)

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end
  end
end