require 'rails_helper'

RSpec.describe "endpoint DELETE /api/v0/tattoos/:id" do
  before(:each) do
    @artist = create(:artist)

    @tattoo = Tattoo.create!({artist_id: @artist.id, price: 250, time_estimate: 90, image_url: "image/path"})
  end

  it 'can delete a tattoo from the database via HTTP request' do
    expect(Tattoo.all.count).to eq(1)
    expect{ delete "/api/v0/tattoos/#{@tattoo.id}" }.to change(Tattoo, :count).by(-1)
    expect{ Tattoo.find(@tattoo.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'when tattoo is deleted, all associated user_tattoos are also destroyed' do
    user = create(:user)
    tattoo_2 = Tattoo.create!({artist_id: @artist.id, price: 250, time_estimate: 90, image_url: "image/path"})
    user_tattoo_1 = UserTattoo.create!({tattoo_id: @tattoo.id, user_id: user.id, status: 0})
    user_tattoo_2 = UserTattoo.create!({tattoo_id: tattoo_2.id, user_id: user.id, status: 1})

    expect(user.tattoos.count).to eq(2)
    delete "/api/v0/tattoos/#{@tattoo.id}"
    expect(user.tattoos.count).to eq(1)
  end

  describe '#sad path' do
    it 'responds with the correct error message if the tattoo does not exist' do
      delete "/api/v0/tattoos/#{@tattoo.id}"
      delete "/api/v0/tattoos/#{@tattoo.id}"

      expect(response).not_to be_successful

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response[:errors].first).to have_key(:detail)
      expect(error_response[:errors].first[:detail]).to eq("Couldn't find Tattoo with 'id'=#{@tattoo.id}")
    end
  end
end