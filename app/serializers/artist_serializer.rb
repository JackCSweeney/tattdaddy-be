class ArtistSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :password, :location, :scheduling_link
end
