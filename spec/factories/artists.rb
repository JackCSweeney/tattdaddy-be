FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    location { Faker::Address.full_address }
    password { "FakePassword1!" }
  end
end
