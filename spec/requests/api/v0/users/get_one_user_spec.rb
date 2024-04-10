require 'rails_helper'

RSpec.describe "Get One User via GET HTTP Request" do
  before(:each) do
    @user = create(:user)
    @id = @user.id

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'can return data from one user based on :id' do
      get "/api/v0/users/:id", headers: @headers

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :attributes, Hash)

      attributes = response_data[:data][:attributes]

      check_hash_structure(attributes, :name, String)
      check_hash_structure(attributes, :email, String)
      check_hash_structure(attributes, :location, String)
      check_hash_structure(attributes, :password_digest, String)
      check_hash_structure(attributes, :search_radius, Integer)
    end
  end

  describe '#sad path' do
    it 'will return with the right error message and unsuccessful error code for not found record' do
      get "/api/v0/users/123123123123123"

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:errors)
      expect(error_response[:errors]).to be_a(Array)

      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Couldn't find User with 'id'=123123123123123")
    end
  end
end

