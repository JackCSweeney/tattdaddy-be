class DistanceService 

  def all_artists_within_radius(user_location, search_radius)
    # user_location = user_location.gsub(", ", "%2C%20")
    artists = []
    Artist.all.each do |artist|
      # artist_location = artist.location.gsub(", ", "%2C%20")
      response = get_url("/maps/api/distancematrix/json?destinations=#{artist.location}&origins=#{user_location}&units=imperial")
      #need distance value to <= search radius
      require 'pry'; binding.pry
      if response <= search_radius
        artists << artist
      end
    end
    artists
    require 'pry'; binding.pry
  end

  def get_url(url) 
    require 'pry'; binding.pry
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    conn = Faraday.new(url: "https://maps.googleapis.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.google_distance_matrix[:api_key]
    end
  end 
end