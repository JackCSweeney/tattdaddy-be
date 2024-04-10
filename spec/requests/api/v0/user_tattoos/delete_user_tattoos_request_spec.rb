require "rails_helper"

RSpec.describe "endpoint delete /api/v0/user_tattoos" do
  describe "As a User" do

    before do
      @user = create(:user)
      @id = @user.id

      @artist = create(:artist)

      @tattoo = Tattoo.create!({artist_id: @artist.id, price: 250, time_estimate: 90, image_url: "image/path"})

      @params = {
        user_id: @id,
        tattoo_id: @tattoo.id
      }

      @headers = {
        "CONTENT_TYPE": "application/json",
        "ACCEPT": "application/json"
      }
    end

    it "deletes a user tattoo relation via HTTP request" do
        delete "/api/v0/user_tattoos", params: JSON.generate(user_tattoo: @params), headers: @headers

        expect(response).to be_successful
        expect(response.status).to eq(204)
    end
  end 
end