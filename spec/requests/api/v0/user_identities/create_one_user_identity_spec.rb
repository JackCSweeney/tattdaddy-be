require 'rails_helper'

RSpec.describe 'Create One UserIdentity via POST HTTP Request' do
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
  end

  describe '#happy path' do
    it 'will return a successful status and create the user_identity record' do
      post "/api/v0/user_identities", headers: @headers, params: JSON.generate(user_identities: @params)

      expect(response).to be_successful

      new_user_identity = UserIdentity.last

      expect(new_user_identity.user_id).to eq(@user.id)
      expect(new_user_identity.identity_id).to eq(@identity.id)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to eq({:message => "Identity successfully added to User"})
    end
  end

  describe '#sad path' do
    it 'returns an error message if user or identity does not exist' do
      post "/api/v0/user_identities", headers: @headers, params: JSON.generate(user_identities: {user_id: 123123123123, identity_id: @identity_id})

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:errors)
      expect(error_response[:errors]).to be_a(Array)

      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Validation failed: User must exist")
    end
  end
end