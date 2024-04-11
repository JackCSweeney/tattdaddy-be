require "rails_helper"

RSpec.describe Artist, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it { should validate_presence_of :location}
    it { should validate_presence_of :password }
  end

  describe "relationships" do
    it {should have_many :tattoos}
    it {should have_many :artist_identities}
    it {should have_many(:identities).through(:artist_identities)}
  end

  before(:each) do
    @artist_1 = create(:artist)
    @artist_2 = create(:artist)

    @tattoo_1 = Tattoo.create!({artist_id: @artist_1.id, price: 250, time_estimate: 90, image_url: "image/path"})
    @tattoo_2 = Tattoo.create!({artist_id: @artist_1.id, price: 350, time_estimate: 100, image_url: "image/path"})
    @tattoo_3 = Tattoo.create!({artist_id: @artist_2.id, price: 150, time_estimate: 60, image_url: "image/path"})

    @identity_1 = Identity.create!(identity_label: "Female")
    @identity_2 = Identity.create!(identity_label: "Black")
    @identity_3 = Identity.create!(identity_label: "Latino")

    @artist_identity_1 = ArtistIdentity.create!({artist_id: @artist_1.id, identity_id: @identity_1.id})
    @artist_identity_2 = ArtistIdentity.create!({artist_id: @artist_1.id, identity_id: @identity_2.id})

    @artist_identity_3 = ArtistIdentity.create!({artist_id: @artist_2.id, identity_id: @identity_3.id})
  end

  describe "instance methods" do 
    describe "#all_artist_tatts" do 
      it "gets all tattoos that are associated with an artist" do 
        expect(@artist_1.tattoos.count).to eq(2)
        expect(@artist_1.all_artist_tatts.count).to eq(2)
        expect(@artist_1.all_artist_tatts.first).to eq(@tattoo_1)
        expect(@artist_1.all_artist_tatts.all).not_to eq(@tattoo_3)

        expect(@artist_2.tattoos.count).to eq(1)
        expect(@artist_2.all_artist_tatts.count).to eq(1)
        expect(@artist_2.all_artist_tatts.first).to eq(@tattoo_3)
        expect(@artist_2.all_artist_tatts.all).not_to eq(@tattoo_1)
      end
    end

    describe "#find_artist_identities" do 
      it "gets all identities that are associated with an artist" do 
        expect(@artist_1.identities.count).to eq(2)
        expect(@artist_1.find_artist_identities.count).to eq(2)
        expect(@artist_1.find_artist_identities.first).to eq(@identity_1)
        expect(@artist_1.find_artist_identities.all).not_to eq(@identity_3)

        expect(@artist_2.identities.count).to eq(1)
        expect(@artist_2.find_artist_identities.count).to eq(1)
        expect(@artist_2.find_artist_identities.first).to eq(@identity_3)
        expect(@artist_2.find_artist_identities.all).not_to eq(@identity_1)
      end
    end
  end
end