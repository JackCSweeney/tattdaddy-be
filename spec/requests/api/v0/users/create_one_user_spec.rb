require 'rails_helper'

RSpec.describe "Create User in DB via HTTP Request" do
  before(:each) do
    @user_data = {
      name: "Jack Sweeney",
      location: "3405 Legend Dr., Los Angeles, CA 90034",
      email: "test@email.com",
      search_radius: 25,
      password: "unreadable_hash"
    }

    @bad_user_data = {
      name: "Jack Sweeney",
      location: "3405 Legend Dr., Los Angeles, CA 90034",
      email: "test@email.com",
      search_radius: 25
    }

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it "can create a new user" do
      post "/api/v0/users", headers: @headers, params: JSON.generate(user: @user_data)

      new_user = User.last

      expect(response).to be_successful
      expect(new_user.name).to eq(@user_data[:name])
      expect(new_user.location).to eq(@user_data[:location])
      expect(new_user.email).to eq(@user_data[:email])
      expect(new_user.search_radius).to eq(@user_data[:search_radius])
      expect(new_user.password_digest).to be_a(String)
    end
  end

  describe '#sad path' do
    it "will return the correct error message and be unsuccessful if any attribute is left blank" do
      post "/api/v0/users", headers: @headers, params: JSON.generate(user: @bad_user_data)

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error_response, :errors, Array)

      errors = error_response[:errors].first

      check_hash_structure(errors, :detail, String)
      expect(errors[:detail]).to eq("Validation failed: Password can't be blank")
    end
  end
end