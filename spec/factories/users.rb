FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    location { Faker::Address.full_address }
    password { "FakePassword1!" }
    search_radius { 25 }
  end
end
