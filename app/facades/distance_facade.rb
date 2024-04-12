class DistanceFacade 

  def initialize(user)
    @user = user 
    @search_radius = user.search_radius
    @location = user.location
  end

  def get_artists_within_distance(user)
    # grab search radius and location from user
    service = DistanceService.new 
    service.all_artists_within_radius(@location, @search_radius)
    # require 'pry'; binding.pry
  end
end