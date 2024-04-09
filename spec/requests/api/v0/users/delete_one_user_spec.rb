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
end
