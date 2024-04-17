require 'rails_helper'

RSpec.describe "Search Controller" do
  # describe 'get search mocked' do
  #   it 'returns filtered artist for user' do
  #     @user = create(:user, location: "22012 G st Crows Landing, CA 95313, USA", search_radius: 100)
  #     i = [
  #           "LGBTQ+",
  #           "Black",
  #           "Native American",
  #           "Latino",
  #           "Female",
  #           "Asian",
  #           "None"
  #           ]

  #       i.each do |identity|
  #         Identity.create!({identity_label: identity})
  #       end
  #       @api_key = Rails.application.credentials.google_distance_matrix[:api_key]
  #       @artist = create(:artist, location: "73 Via Jodi Gustine, CA 95322, USA")
  #       UserIdentity.create!({user_id: @user.id, identity_id: Identity.all.first.id})
  #       UserIdentity.create!({user_id: @user.id, identity_id: Identity.all[1].id})
  #       ArtistIdentity.create!({artist_id: @artist.id, identity_id: Identity.all[1].id})
  #       ArtistIdentity.create!({artist_id: @artist.id, identity_id: Identity.all[2].id})
        
  #       get "/api/v0/distance_search/#{@user.id}"
  #       json_response = File.read("spec/fixtures/distance_sample.json")
        
  #       stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=73%20Via%20Jodi%20Gustine,%20CA%2095322,%20USA&key=AIzaSyCLnZRm2mUkbaG0xplrrNY-EBeXMVfamnk&origins=22012%20G%20st%20Crows%20Landing,%20CA%2095313,%20USA&units=imperial").
  #        with(
  #          headers: {
  #         'Accept'=>'*/*',
  #         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #         'User-Agent'=>'Faraday v2.9.0'
  #          }).
  #        to_return(status: 200, body: json_response, headers: {})

  #       expect(response).to have_http_status(:success)
  #       expect(response.content_type).to eq("application/json")

  #   end
  # end
  
  describe 'GET #search' do
    let(:user) { create(:user) }
    let(:distance_facade) { instance_double(DistanceFacade) }
    let(:artists) { [create(:artist)] }

    before do
      allow(User).to receive(:find).with(user.id.to_s).and_return(user)
      allow(DistanceFacade).to receive(:new).with(user).and_return(distance_facade)
      allow(distance_facade).to receive(:get_artists_within_distance).with(user).and_return(artists)
    end

    xit 'returns artists within user search radius' do
      # get :search, params: { user_id: user.id }
        get "/api/v0/distance_search/#{user.id}"


      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq(artists.map(&:as_json))
    end
  end
end
