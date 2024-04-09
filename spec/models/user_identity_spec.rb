require "rails_helper"

RSpec.describe UserIdentity, type: :model do
  describe "relationships" do
    it {should belong_to :user}
    it {should belong_to :identity}
  end
end