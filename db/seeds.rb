# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# create identities for artists and users to use for associations
ArtistIdentity.destroy_all
UserIdentity.destroy_all
UserTattoo.destroy_all
Identity.destroy_all
Tattoo.destroy_all
Artist.destroy_all
User.destroy_all

i = [
  "LGBTQ+",
  "Black",
  "Native American",
  "Latino",
  "Female",
  "Asian",
  "None"
]

i.each do |identity|
  Identity.create!({identity_label: identity})
end

identities = Identity.all

# create artists
5.times do
  Artist.create!({name: Faker::Name.name, email: Faker::Internet.email, location: Faker::Address.full_address, password: "FakePassword1!"})
end

artists = Artist.all

# create tattoos
artists.each do |artist|
  3.times do
    Tattoo.create!({artist_id: artist.id, image_url: "/random/url/path", time_estimate: Faker::Number.between(from: 60, to: 180), price: Faker::Number.between(from: 150, to: 500)})
  end
end

# create users
5.times do
  User.create!({name: Faker::Name.name, email: Faker::Internet.email, location: Faker::Address.full_address, password: "FakePassword1!", search_radius: 25})
end

users = User.all

# create user_tattoos
users.each do |user|
  UserTattoo.create!({user_id: user.id, tattoo_id: Tattoo.last.id, status: 0})
end

# create user_identities
UserIdentity.create!({user_id: users.first.id, identity_id: identities.first.id})
UserIdentity.create!({user_id: users[1].id, identity_id: identities.last.id})
UserIdentity.create!({user_id: users[2].id, identity_id: identities[3].id})

# create artist_identities
ArtistIdentity.create!({artist_id: artists.first.id, identity_id: identities.first.id})
ArtistIdentity.create!({artist_id: artists[1].id, identity_id: identities.last.id})
ArtistIdentity.create!({artist_id: artists[2].id, identity_id: identities[3].id})