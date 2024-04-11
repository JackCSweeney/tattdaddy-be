require "rails_helper"

RSpec.describe UserIdentity, type: :model do
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:identity_id) }
  end
  
  describe "relationships" do
    it {should belong_to :user}
    it {should belong_to :identity}
  end
end