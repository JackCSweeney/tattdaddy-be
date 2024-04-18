require 'rails_helper'

RSpec.describe "Search Controller" do 
  describe 'GET #search' do
    let(:user) { create(:user) }
    let(:distance_facade) { instance_double(DistanceFacade) }
    let(:artists) { [create(:artist)] }

    before do
      allow(User).to receive(:find).with(user.id.to_s).and_return(user)
      allow(DistanceFacade).to receive(:new).with(user).and_return(distance_facade)
      allow(distance_facade).to receive(:get_artists_within_distance).with(user).and_return(artists)
    end

    it 'returns artists within user search radius' do
      artist = artists.first 
      3.times do
        Tattoo.create!({artist_id: artist.id, image_url: "/random/url/path", time_estimate: Faker::Number.between(from: 60, to: 180), price: Faker::Number.between(from: 150, to: 500)})
      end
    
      get "/api/v0/tattoos?user=#{user.id}"
      
      expect(response).to have_http_status(:success)

      response_data = JSON.parse(response.body, symbolize_names: true)
      response_data[:data].each do |tattoo_data|

        check_hash_structure(tattoo_data, :id, String)
        check_hash_structure(tattoo_data, :attributes, Hash)

        attribute = tattoo_data[:attributes]
          expect(attribute).to have_key(:price)
          expect(attribute).to have_key(:artist_id)
          expect(attribute).to have_key(:time_estimate)
          expect(attribute).to have_key(:image_url)
        
      end
    end

    it 'returns artists within user search radius' do
      allow(distance_facade).to receive(:get_artists_within_distance).with(user).and_return("not found")
      artist = artists.first 
      3.times do
        Tattoo.create!({artist_id: artist.id, image_url: "/random/url/path", time_estimate: Faker::Number.between(from: 60, to: 180), price: Faker::Number.between(from: 150, to: 500)})
      end
    
      get "/api/v0/tattoos?user=#{user.id}"
      
      expect(response).to_not have_http_status(:success)

      response_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response_data).to be_a(Hash)
      expect(response_data).to include(:errors)
      expect(response_data[:errors]).to be_an(Array)
      expect(response_data[:errors][0]).to be_a(Hash)
      expect(response_data[:errors][0]).to include(:detail)
      expect(response_data[:errors][0][:detail]).to eq("Must have correct location to find tattoos")
        
    end
  end
end
