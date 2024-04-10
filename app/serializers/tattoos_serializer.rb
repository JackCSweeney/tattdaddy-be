class TattoosSerializer
  include JSONAPI::Serializer
  attributes :price, :time_estimate, :artist_id, :image_url
end
