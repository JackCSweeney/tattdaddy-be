require 'rails_helper'

RSpec.describe "Delete User via HTTP Request" do
  before(:each) do
    create_list(:user, 5)
    @user = create(:user)
  end

  it 'can delete a user from the database via HTTP request' do
    expect(User.all.count).to eq(6)
    expect{ delete "/api/v0/users/#{@user.id}" }.to change(User, :count).by(-1)
    expect{ User.find(@user.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  
  it 'will return the correct message and status when given a user id that does not exist' do
    delete "/api/v0/users/#{@user.id}"
    
    delete "/api/v0/users/#{@user.id}"

    expect(response).not_to be_successful
    
    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to be_a(Array)

    expect(error_response[:errors].first).to have_key(:detail)
    expect(error_response[:errors].first[:detail]).to eq("Couldn't find User with 'id'=#{@user.id}")
  end
end
