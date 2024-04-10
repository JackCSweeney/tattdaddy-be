require 'rails_helper'

RSpec.describe "Get all UserTattoos via GET HTTP Request" do
  before(:each) do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @artist = create(:artist)

    @tattoo_1 = Tattoo.create!({artist_id: @artist.id, price: 250, time_estimate: 90, image_url: "image/path"})
    @tattoo_2 = Tattoo.create!({artist_id: @artist.id, price: 350, time_estimate: 100, image_url: "image/path"})
    @tattoo_3 = Tattoo.create!({artist_id: @artist.id, price: 150, time_estimate: 60, image_url: "image/path"})

    @user_tattoo_1 = UserTattoo.create!({tattoo_id: @tattoo_1.id, user_id: @user_1.id})
    @user_tattoo_2 = UserTattoo.create!({tattoo_id: @tattoo_2.id, user_id: @user_1.id})

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'will return all tattoos that are associated with the given user' do
      get "/api/v0/users/#{@user_1.id}/tattoos", headers: @headers

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Array)

      response_data[:data].each do |tattoo|
        expect(tattoo).to have_key(:id)
        expect(tattoo).to have_key(:attributes)
        
        attributes = tattoo[:attributes]

        check_hash_structure(attributes, :artist_id, String)
        check_hash_structure(attributes, :price, Integer)
        check_hash_structure(attributes, :time_estimate, Integer)
        check_hash_structure(attributes, :image_url, String)
      end
    end

    it 'will return an empty array if no tattoos are found for the user' do
      get "/api/v0/users/#{@user_2.id}/tattoos", headers: @headers

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Array)
      expect(response_data[:data].empty?).to eq(true)
    end
  end

  describe '#sad path' do
    it 'will return the correct error message when given invalid user id' do
      get "/api/v0/users/123123123123/tattoos"

      expect(response).not_to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :errors, Array)
      expect(response_data[:errors].first).to be_a(Hash)
      check_hash_structure(response_data[:errors].first, :detail, String)
      expect(response_data[:errors].first[:detail]).to eq("Couldn't find User with 'id'=123123123123")
    end
  end
end