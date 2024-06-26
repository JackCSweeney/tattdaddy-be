require 'rails_helper'

RSpec.describe Identity, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:identity_label) }
  end

  describe 'relationships' do
    it { should have_many :artist_identities }
    it { should have_many :user_identities }
  end
end