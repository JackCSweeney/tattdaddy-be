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

  describe 'enums' do
    it { should define_enum_for(:status).with_values(["liked", "disliked"]) }
  end

  describe '#class methods' do
    describe '#delete_disliked_tattoos(user_id)' do
      it 'can delete all UserTattoos with the status of 1 (disliked)' do
        user = create(:user)
        artist = create(:artist)

        tattoo_1 = Tattoo.create!({price: 100, time_estimate: 90, artist_id: artist.id, image_url: "test/url/path"})
        tattoo_2 = Tattoo.create!({price: 150, time_estimate: 90, artist_id: artist.id, image_url: "test/url/path"})
        tattoo_3 = Tattoo.create!({price: 200, time_estimate: 90, artist_id: artist.id, image_url: "test/url/path"})

        user_tattoo_1 = UserTattoo.create!({user_id: user.id, tattoo_id: tattoo_1.id, status: 1})
        user_tattoo_2 = UserTattoo.create!({user_id: user.id, tattoo_id: tattoo_2.id, status: 1})
        user_tattoo_3 = UserTattoo.create!({user_id: user.id, tattoo_id: tattoo_3.id, status: 0})

        expect(user.tattoos.include?(tattoo_1)).to eq(true)
        expect(user.tattoos.include?(tattoo_2)).to eq(true)
        expect(user.tattoos.include?(tattoo_3)).to eq(true)

        UserTattoo.delete_disliked_tattoos(user.id)

        expect(user.tattoos.include?(tattoo_1)).to eq(false)
        expect(user.tattoos.include?(tattoo_2)).to eq(false)
        expect(user.tattoos.include?(tattoo_3)).to eq(true)
      end
    end
  end
end