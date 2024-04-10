require 'rails_helper'

RSpec.describe "Edit One User via Patch HTTP Request" do
  before(:each) do
    @user = create(:user)

    @name = @user.name
    @location = @user.location
    @email = @user.email
    @search_radius = @user.search_radius
    
    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  describe '#happy path' do
    it 'can edit an existing users attributes through a patch http request' do
      user_params = {name: "Fake Testname"}

      patch "/api/v0/users/#{@user.id}", headers: @headers, params: JSON.generate({user: user_params})

      expect(response).to be_successful

      edit_response = JSON.parse(response.body, symbolize_names: true)

      check_hash_structure(edit_response, :data, Hash)
      check_hash_structure(edit_response[:data], :attributes, Hash)
      
      updated_user_data = edit_response[:data][:attributes]

      expect(updated_user_data[:name]).not_to eq(@name)
      expect(updated_user_data[:name]).to eq(user_params[:name])
    end
  end

  describe '#sad path' do
    it 'wont be successful if trying to update with a blank attribute' do

    end
  end
end