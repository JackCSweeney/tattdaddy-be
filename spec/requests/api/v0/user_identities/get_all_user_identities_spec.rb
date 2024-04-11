require 'rails_helper'

RSpec.describe 'Get All UserIdentity Records via GET HTTP Request' do
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

    @identity_1 = Identity.first
    @identity_2 = Identity.all[1]
    @user = create(:user)

    @headers = {"CONTENT_TYPE" => "application/json"}

    @params_1 = {
      user_id: @user.id,
      identity_id: @identity_1.id
    }
    @params_2 = {
      user_id: @user.id,
      identity_id: @identity_2.id
    }

    @user_identity_1 = UserIdentity.create!(@params_1)
    @user_identity_2 = UserIdentity.create!(@params_2)
  end

  describe '#happy path' do
    it 'returns all identities associated with the user' do
      get "/api/v0/users/#{@user.id}/identities", headers: @headers

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Array)
      check_hash_structure(response_data[:data].first, :attributes, Hash)

      attributes = response_data[:data].first[:attributes]

      expect(attributes[:identity_label]).to eq("LGBTQ+")
    end
  end

  describe '#sad path' do
    it 'will give a 404 error if the user does not exist' do
      get "/api/v0/users/123123123/identities", headers: @headers

      expect(response).not_to be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(error, :errors, Array)
      expect(error[:errors].first).to have_key(:detail)
      expect(error[:errors].first[:detail]).to eq("Couldn't find User with 'id'=123123123")
    end
  end
end