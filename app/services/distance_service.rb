class DistanceService 
  def get_url(url) 
    response = conn.get(url)

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def conn 
    conn = Faraday.new(url: "https://maps.googleapis.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.google_distance_matrix[:key]
    end
  end 
end