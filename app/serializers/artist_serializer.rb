class ArtistSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :password, :location
end
