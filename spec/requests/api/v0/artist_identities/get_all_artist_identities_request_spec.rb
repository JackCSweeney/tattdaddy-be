require "rails_helper"

RSpec.describe "endpoint get /api/v0/artists/:id/identities" do
  describe "As a User" do

    before do
      @artist_1 = create(:artist)
      @artist_2 = create(:artist)

      @identity_1 = Identity.create!(identity_label: "Female")
      @identity_2 = Identity.create!(identity_label: "Black")
      @identity_3 = Identity.create!(identity_label: "Latino")

      @artist_identity_1 = ArtistIdentity.create!({artist_id: @artist_1.id, identity_id: @identity_1.id})
      @artist_identity_2 = ArtistIdentity.create!({artist_id: @artist_1.id, identity_id: @identity_2.id})

      @artist_identity_3 = ArtistIdentity.create!({artist_id: @artist_2.id, identity_id: @identity_3.id})

      @headers = {"CONTENT_TYPE" => "application/json"}
    end

    it "will return all identities that are associated with the given artist" do
      get "/api/v0/artists/#{@artist_1.id}/identities", headers: @headers

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(response_data, :data, Array)

      response_data[:data].each do |identity|
        expect(identity).to have_key(:id)
        expect(identity).to have_key(:attributes)
        
        attributes = identity[:attributes]

        check_hash_structure(attributes, :identity_label, String)
      end 
    end
  end 
end