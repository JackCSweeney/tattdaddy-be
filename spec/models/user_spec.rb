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
end