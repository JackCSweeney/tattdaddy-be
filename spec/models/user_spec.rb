require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it { should validate_presence_of :location}
    it { should validate_presence_of :password }
    it { should validate_presence_of :search_radius }
  end

  describe "relationships" do
    it {should have_many :user_tattoos}
    it {should have_many :user_identities}
    it {should have_many(:identities).through(:user_identities)}
    it {should have_many(:tattoos).through(:user_tattoos)}
  end

  before(:each) do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @artist = create(:artist)

    @tattoo_1 = Tattoo.create!({artist_id: @artist.id, price: 250, time_estimate: 90, image_url: "image/path"})
    @tattoo_2 = Tattoo.create!({artist_id: @artist.id, price: 350, time_estimate: 100, image_url: "image/path"})
    @tattoo_3 = Tattoo.create!({artist_id: @artist.id, price: 150, time_estimate: 60, image_url: "image/path"})

    @user_tattoo_1 = UserTattoo.create!({tattoo_id: @tattoo_1.id, user_id: @user_1.id})
    @user_tattoo_2 = UserTattoo.create!({tattoo_id: @tattoo_2.id, user_id: @user_1.id})
  end

  describe '#instance methods' do
    describe '#find_user_tatts' do
      it 'returns all tattoos for the given user' do
        expect(@user_1.find_user_tatts.first).to eq(@tattoo_1)
        expect(@user_1.find_user_tatts.last).to eq(@tattoo_2)
        expect(@user_2.find_user_tatts.empty?).to eq(true)
      end
    end
  end
end