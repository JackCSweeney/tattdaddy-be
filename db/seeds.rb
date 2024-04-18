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
Artist.create!({name: "Hugh Jalligator", email: "hugh@jalligator.com", location: "1453 Swamp Ln, Los Angeles, CA 90032", password: "FakePassword1!", scheduling_link: "link/path"})
Artist.create!({name: "Doug Dimmadome", email: "doug@dimmadome.com", location: "356 Dome St, Los Angeles, CA 90032", password: "FakePassword1!", scheduling_link: "link/path"})
Artist.create!({name: "Greg Leggington", email: "greg@leggington.com", location: "154 Field Goal St, Los Angeles, CA 90032", password: "FakePassword1!", scheduling_link: "link/path"})
Artist.create!({name: "Tom Maybe", email: "tom@maybe.com", location: "987 Hand Egg Circle, Los Angeles, CA 90032", password: "FakePassword1!", scheduling_link: "link/path"})
Artist.create!({name: "Ivy Running", email: "ivy@running.com", location: "45 Marathon Rd, Los Angeles, CA 90032", password: "FakePassword1!", scheduling_link: "link/path"})

artists = Artist.all

# create tattoos
artists.each do |artist|
  3.times do
    Tattoo.create!({artist_id: artist.id, image_url: "/random/url/path", time_estimate: 90, price: 200})
  end
end

# create users
User.create!({name: "Jack", email: "fakeemail1@email.com", location: "1453 Swamp Ln, Los Angeles, CA 90032", password: "FakePassword1!", search_radius: 25})
User.create!({name: "Joey", email: "fakeemail2@email.com", location: "356 Dome St, Los Angeles, CA 90032", password: "FakePassword1!", search_radius: 25})
User.create!({name: "Faisal", email: "fakeemail3@email.com", location: "154 Field Goal St, Los Angeles, CA 90032", password: "FakePassword1!", search_radius: 25})
User.create!({name: "Laura", email: "fakeemail4@email.com", location: "987 Hand Egg Circle, Los Angeles, CA 90032", password: "FakePassword1!", search_radius: 25})
User.create!({name: "Jess", email: "fakeemail5@email.com", location: "45 Marathon Rd, Los Angeles, CA 90032", password: "FakePassword1!", search_radius: 25})

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
