require "rails_helper"

RSpec.describe "endpoint post /api/v0/user_tattoos" do
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

    it "creates a user tattoos relation via HTTP request" do
      post "/api/v0/user_tattoos", params: JSON.generate(user_tattoo: @params), headers: @headers

      new_user_tattoo = UserTattoo.last 
      
      expect(new_user_tattoo.user_id).to eq(@id)
      expect(new_user_tattoo.tattoo_id).to eq(@tattoo.id)
      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to eq({:message => "Tattoo successfully added to User"})
    end

    describe "Sad Path" do 
      it "sends an error when a relation between User and Tattoo already exists" do 
        post "/api/v0/user_tattoos", params: JSON.generate(user_tattoo: @params), headers: @headers
        
        post "/api/v0/user_tattoos", params: JSON.generate(user_tattoo: @params), headers: @headers
        
        expect(response).not_to be_successful
        expect(response.status).to eq(422)

        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response).to have_key(:errors)
        expect(error_response[:errors]).to be_a(Array)

        expect(error_response[:errors].first).to have_key(:detail)
        expect(error_response[:errors].first[:detail]).to eq("Validation failed: Tattoo has already been taken")
      end 
    end
  end 
end