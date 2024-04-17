require 'rails_helper'

RSpec.describe "Can Sign Out User via DELETE HTTP Request" do
  before(:each) do
    @user = create(:user, password: "Test")
    @artist = create(:artist)

    @tattoo_1 = Tattoo.create!({price: 100, time_estimate: 90, artist_id: @artist.id, image_url: "test/url/path"})
    @tattoo_2 = Tattoo.create!({price: 150, time_estimate: 90, artist_id: @artist.id, image_url: "test/url/path"})
    @tattoo_3 = Tattoo.create!({price: 200, time_estimate: 90, artist_id: @artist.id, image_url: "test/url/path"})

    @user_tattoo_1 = UserTattoo.create!({tattoo_id: @tattoo_1.id, user_id: @user.id, status: 0})
    @user_tattoo_2 = UserTattoo.create!({tattoo_id: @tattoo_2.id, user_id: @user.id, status: 1})
    @user_tattoo_3 = UserTattoo.create!({tattoo_id: @tattoo_3.id, user_id: @user.id, status: 1})

    @headers = {"CONTENT_TYPE" => "application/json"}

    @sign_in_params = {
        email: @user.email,
        password: "Test",
        type: "Sign In as User"
    }
    @sign_out_params = {user_id: @user.id}
    @bad_params = {}

    post "/api/v0/sign_in", headers: @headers, params: JSON.generate(@sign_in_params)
  end

  describe '#happy path' do
    it 'can recieve the request and return a success for successfully siging out a user' do
      delete "/api/v0/sign_out", headers: @headers, params: JSON.generate(@sign_out_params)

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
    
    it 'can recieve the request and delete user_tattoos that have a disliked status' do
      delete "/api/v0/sign_out", headers: @headers, params: JSON.generate(@sign_out_params)

      expect(response).to be_successful
      expect(@user.tattoos.include?(@tattoo_1)).to eq(true)
      expect(@user.tattoos.include?(@tattoo_2)).to eq(false)
      expect(@user.tattoos.include?(@tattoo_3)).to eq(false)
    end
  end

  describe '#sad path' do
    it 'will not log out the user if not given correct body information' do
      delete "/api/v0/sign_out", headers: @headers, params: JSON.generate(@bad_params)

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
    end
  end
end