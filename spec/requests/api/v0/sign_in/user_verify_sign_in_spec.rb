require 'rails_helper'

RSpec.describe "Verify User Info for Sign In via HTTP Request" do
  before(:each) do
    @user = create(:user, password: "Test")

    @params_1 = {
      sign_in: {
        email: @user.email,
        password: "Test",
        type: "Sign In as User"
      },
      conroller: "sessions",
      action: "create"
    }

    @params_2 = {
      sign_in: {
        email: @user.email,
        password: "WrongPassword",
        type: "Sign In as User"
      },
      conroller: "sessions",
      action: "create"
    }

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'can verify a users login credentials and return the user data with correct status' do
      post "/api/v0/sign_in", headers: @headers, params: JSON.generate(@params_1)

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Hash)
      check_hash_structure(response_data[:data], :id, String)
      
      attributes = response_data[:data][:attributes]

      check_hash_structure(attributes, :email, String)
      check_hash_structure(attributes, :location, String)
      check_hash_structure(attributes, :search_radius, String)
      check_hash_structure(attributes, :name, String)
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