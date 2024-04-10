require 'rails_helper'

RSpec.describe "Create User in DB via HTTP Request" do
  before(:each) do
    @user_data = {
      name: "Jack Sweeney",
      location: "3405 Legend Dr. Los Angeles, CA 90034",
      email: "test@email.com",
      search_radius: 25,
      password: "unreadable_hash"
    }

    @headers = {"CONTENT_TYPE" => "application/json"}
  end

  it "can create a new user" do
    post "/api/v0/users", headers: @headers, params: JSON.generate(user: @user_data)

    new_user = User.last

    expect(response).to be_successful
    expect(new_user.name).to eq(@user_data[:name])
    expect(new_user.location).to eq(@user_data[:location])
    expect(new_user.email).to eq(@user_data[:email])
    expect(new_user.search_radius).to eq(@user_data[:search_radius])
    expect(new_user.password_digest).to be_a(String)
  end
end