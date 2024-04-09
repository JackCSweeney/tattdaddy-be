require 'rails_helper'

RSpec.describe Identity, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:identity_label) }
  end

  describe 'relationships' do
    it { should belong_to :artist }
    it { should belong_to :user }
  end
end