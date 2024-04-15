class DistanceService 

  def all_artists_within_radius(user_location, search_radius)
    
    artists = []
    Artist.all.each do |artist|
      
      response = get_url("/maps/api/distancematrix/json?destinations=#{artist.location}&origins=#{user_location}&units=imperial")
     
      
      
      distance_text = response[:rows].first[:elements].first[:distance][:text]
      distance_float = distance_text.gsub(/[^\d.]/, '').to_f
     
      if distance_float <= search_radius
        artists << artist
      end
    end
    artists
   
  end

  def get_url(url) 
   
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    conn = Faraday.new(url: "https://maps.googleapis.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.google_distance_matrix[:api_key]
    end
  end 
end