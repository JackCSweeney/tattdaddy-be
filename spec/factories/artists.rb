FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    location { Faker::Address.full_address }
    scheduling_link { Faker::Internet.url }
    password { "FakePassword1!" }
  end
end
