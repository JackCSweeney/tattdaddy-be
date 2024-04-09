require 'rails_helper'

RSpec.describe UserTattoo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:tattoo_id) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :tattoo }
  end

  describe 'instance methods' do
  end
end