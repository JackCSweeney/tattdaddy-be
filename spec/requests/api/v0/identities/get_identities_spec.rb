require 'rails_helper'

RSpec.describe 'Get All Identities via GET HTTP Request' do
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

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'will return all of the identities stored in Identities table within data base to be used for artist and user identities/preferences' do
      get "/api/v0/identities", headers: @headers

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Array)
      expect(response[:data].first).to be_a(Hash)

      data = response_data[:data]

      data.each do |identity|
        check_hash_structure(identity, :id, String)
        check_hash_structure(identity, :type, String)
        check_hash_structure(identity[:attributes], :identity_label, String)
      end
    end
  end
end