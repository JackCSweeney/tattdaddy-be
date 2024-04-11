require 'rails_helper'

RSpec.describe 'Delete One UserIdentity via POST HTTP Request' do
  before(:each) do
    i = [
    "LGBTQ+",
    "Black",
    "Native American",
    "Latino",
    "Female",
    "Asian",
    "None"
    ]

    i.each do |identity|
      Identity.create!({identity_label: identity})
    end

    @identity = Identity.first
    @user = create(:user)

    @headers = {"CONTENT_TYPE" => "application/json"}

    @params = {
      user_id: @user.id,
      identity_id: @identity.id
    }

    UserIdentity.create!({user_id: @user.id, identity_id: @identity.id})
  end

  describe '#happy path' do
    it 'can delete a UserIdentity via DELETE HTTP request' do
      delete "/api/v0/user_identities", headers: @headers, params: JSON.generate(user_identity: @params)

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end

  describe '#sad path' do
    it 'returns the correct error response when trying to delete a record that does not exist' do
      delete "/api/v0/user_identities", params: JSON.generate(user_identity: @params), headers: @headers

      delete "/api/v0/user_identities", params: JSON.generate(user_identity: @params), headers: @headers
      expect(response).not_to be_successful
      expect(response.status).to eq(404)

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:message)
      expect(error_response[:message]).to eq("Association between Identity and User does not exist")
    end
  end
end