require 'rails_helper'

RSpec.describe DistanceService do
  describe '#all_artists_within_radius' do
    let(:user_location) { '22012 G st Crows Landing, CA 95313, USA' }
    let(:search_radius) { 10.0 }
    let(:artist1_location) { '721 Willow St San Jose, CA 95125, USA' }
    let(:artist2_location) { '1900 S Central Ave Los Angeles, CA 90011, USA' }

    it 'returns artists within the search radius' do
      
      allow_any_instance_of(DistanceService).to receive(:get_url).and_return(
        {
          rows: [
            {
              elements: [
                {
                  distance: { text: '5 mi' }
                }
              ]
            }
          ]
        }
      )

    
      artist1 = create(:artist, location: artist1_location)
      artist2 = create(:artist, location: artist2_location)

      filtered_artists = Artist.all
      service = DistanceService.new
      artists_within_radius = service.all_artists_within_radius(user_location, search_radius, filtered_artists)

      
      expect(artists_within_radius).to contain_exactly(artist1, artist2)
    end

    it 'returns no artists within the search radius' do
      
      allow_any_instance_of(DistanceService).to receive(:get_url).and_return(
        {
          rows: [
            {
              elements: [
                {
                  distance: { text: '15 mi' }
                }
              ]
            }
          ]
        }
      )

      
      artist1 = create(:artist, location: artist1_location)
      artist2 = create(:artist, location: artist2_location)

      filtered_artists = Artist.all
      
      service = DistanceService.new
      artists_within_radius = service.all_artists_within_radius(user_location, search_radius, filtered_artists)

      
      expect(artists_within_radius).to be_empty
    end
    it 'returns not found for bad address' do
      
      allow_any_instance_of(DistanceService).to receive(:get_url).and_return(
        {
          rows: [
            {
              "elements": [
                {
                    "status": "NOT_FOUND"
                }
              ]
            }
          ]
        }
      )

      
      artist1 = create(:artist, location: artist1_location)
      artist2 = create(:artist, location: artist2_location)

      filtered_artists = Artist.all
      service = DistanceService.new
      artists_within_radius = service.all_artists_within_radius(user_location, search_radius, filtered_artists)

      
      expect(artists_within_radius).to eq("not found")
    end
  end
end
