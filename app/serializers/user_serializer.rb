class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :location, :email, :search_radius, :password
end
