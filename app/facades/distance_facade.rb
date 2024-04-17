class DistanceFacade 

  def initialize(user)
    @user = user 
    @search_radius = user.search_radius
    @location = user.location
  end

  def get_artists_within_distance(user)
    service = DistanceService.new 
    artists = Artist.all
      matched_artists = Artist.joins(artist_identities: :identity)
                               .where(id: artists.map(&:id)) 
                               .where(artist_identities: { identity_id: user.identity_ids })
                               .distinct
      matched_artists
      service.all_artists_within_radius(@location, @search_radius, matched_artists)
  end
end