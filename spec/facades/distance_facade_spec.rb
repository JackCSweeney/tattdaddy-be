require "rails_helper"

RSpec.describe DistanceFacade do
  describe "As a User" do
    before do
      @user = create(:user, location: "22012 G st Crows Landing, CA 95313, USA", search_radius: 100)
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
        @api_key = Rails.application.credentials.google_distance_matrix[:api_key]
    end
    
    it "returns filtered artists within search radius" do
      artist = create(:artist, location: "73 Via Jodi Gustine, CA 95322, USA")
      UserIdentity.create!({user_id: @user.id, identity_id: Identity.all.first.id})
      UserIdentity.create!({user_id: @user.id, identity_id: Identity.all[1].id})
      ArtistIdentity.create!({artist_id: artist.id, identity_id: Identity.all[1].id})
      ArtistIdentity.create!({artist_id: artist.id, identity_id: Identity.all[2].id})
      # this should be the correct endpoint needed from: https://developers.google.com/maps/documentation/distance-matrix/start
      json_response = File.read("spec/fixtures/distance_sample.json")
      stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=73%20Via%20Jodi%20Gustine,%20CA%2095322,%20USA&key=#{@api_key}&origins=22012%20G%20st%20Crows%20Landing,%20CA%2095313,%20USA&units=imperial").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: json_response, headers: {})
      response_data = DistanceFacade.new(@user).get_artists_within_distance(@user)
      expect(response_data).to_not eq([])
      expect(response_data.length).to eq(1)
      expect(response_data[0]).to be_an(Artist)
    end


    it "returns filtered artists within search radius" do
      artist = create(:artist, location: "73 Via Jodi Gustine, CA 95322, USA")
      UserIdentity.create!({user_id: @user.id, identity_id: Identity.all.first.id})
      UserIdentity.create!({user_id: @user.id, identity_id: Identity.all[1].id})
      ArtistIdentity.create!({artist_id: artist.id, identity_id: Identity.all[3].id})
      ArtistIdentity.create!({artist_id: artist.id, identity_id: Identity.all[2].id})
      # this should be the correct endpoint needed from: https://developers.google.com/maps/documentation/distance-matrix/start
      json_response = File.read("spec/fixtures/distance_sample.json")
      stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=73%20Via%20Jodi%20Gustine,%20CA%2095322,%20USA&key=#{@api_key}&origins=22012%20G%20st%20Crows%20Landing,%20CA%2095313,%20USA&units=imperial").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: json_response, headers: {})
      response_data = DistanceFacade.new(@user).get_artists_within_distance(@user)
      expect(response_data).to eq([])
    end
    it "returns only artists within search radius" do
      # this should be the correct endpoint needed from: https://developers.google.com/maps/documentation/distance-matrix/start
      artist2 = create(:artist, location: "1900 S Central Ave Los Angeles, CA 90011, USA")
      json_response = File.read("spec/fixtures/distance_sample1.json")
        stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=1900%20S%20Central%20Ave%20Los%20Angeles,%20CA%2090011,%20USA&key=#{@api_key}&origins=22012%20G%20st%20Crows%20Landing,%20CA%2095313,%20USA&units=imperial").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
        to_return(status: 200, body: json_response, headers: {})
      response_data = DistanceFacade.new(@user).get_artists_within_distance(@user)
      expect(response_data).to eq([])
    end

    it "returns filtered artists within search radius sad path" do
      user1 = create(:user, location: "kjhkj", search_radius: 100)
      artist = create(:artist, location: "73 Via")
      UserIdentity.create!({user_id: user1.id, identity_id: Identity.all.first.id})
      UserIdentity.create!({user_id: user1.id, identity_id: Identity.all[1].id})
      ArtistIdentity.create!({artist_id: artist.id, identity_id: Identity.all[1].id})
      ArtistIdentity.create!({artist_id: artist.id, identity_id: Identity.all[2].id})
      # this should be the correct endpoint needed from: https://developers.google.com/maps/documentation/distance-matrix/start
      json_response = File.read("spec/fixtures/sad_path.json")
      stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=73%20Via&key=AIzaSyCLnZRm2mUkbaG0xplrrNY-EBeXMVfamnk&origins=kjhkj&units=imperial").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
          to_return(status: 200, body: json_response, headers: {})
      response_data = DistanceFacade.new(user1).get_artists_within_distance(user1)
      expect(response_data).to eq("not found")   
    end
  end
end