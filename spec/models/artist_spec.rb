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
end