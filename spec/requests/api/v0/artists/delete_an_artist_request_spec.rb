require "rails_helper"

RSpec.describe "endpoint delete api/v0/artists/:id" do
  describe "As a user" do

    before do
      create_list(:artist, 5)
      @artist = create(:artist)
    end

    it "can delete a artist from the database via HTTP request" do
      expect(Artist.all.count).to eq(6)
      expect{ delete "/api/v0/artists/#{@artist.id}" }.to change(Artist, :count).by(-1)
      expect{ Artist.find(@artist.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    describe "sad path" do 
      it "will return the correct message and status when given a user id that does not exist" do 
        delete "/api/v0/artists/#{@artist.id}"
    
        delete "/api/v0/artists/#{@artist.id}"

        expect(response).not_to be_successful
        
        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response).to have_key(:errors)
        expect(error_response[:errors]).to be_a(Array)

        expect(error_response[:errors].first).to have_key(:detail)
        expect(error_response[:errors].first[:detail]).to eq("Couldn't find Artist with 'id'=#{@artist.id}")
      end
    end
  end 
end