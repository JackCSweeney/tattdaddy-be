require "rails_helper"

RSpec.describe DistanceFacade do
  describe "As a User" do

    before do
      @user = create(:user, location: "22012 G st Crows Landing, CA 95313, USA", search_radius: 228)
      @artist = create(:artist, location: "73 Via Jodi Gustine, CA 95322, USA")
    end
    
    it "returns artists within search radius" do
      # this should be the correct endpoint needed from: https://developers.google.com/maps/documentation/distance-matrix/start
      json_response = File.read("spec/fixtures/distance_sample.json")
      stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=73%20Via%20Jodi%20Gustine,%20CA%2095322,%20USA&origins=22012%20G%20st%20Crows%20Landing,%20CA%2095313,%20USA&units=imperial").
        to_return(status: 200, body: json_response)

      response_data = DistanceFacade.new(@user).get_artists_within_distance(@user)
        # require 'pry'; binding.pry
    end
  end
end