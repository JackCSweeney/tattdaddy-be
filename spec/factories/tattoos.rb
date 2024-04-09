FactoryBot.define do
  factory :tattoo do
    image_url { "/random/url/path" }
    time_estimate { Faker::Number.between(from: 60, to: 180) }
    price { Faker::Number.between(from: 150, to: 500) }
    artist_id { 1 }
  end
end
