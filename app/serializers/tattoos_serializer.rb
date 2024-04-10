class TattoosSerializer
  include JSONAPI::Serializer
  attributes :image_url, :price, :time_estimate, :artist_id
end
