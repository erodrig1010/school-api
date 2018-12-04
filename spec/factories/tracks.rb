FactoryBot.define do
  factory :track do
    name { Faker::Name.track }
    url { Faker::Internet.url }
    school_id { nil }
  end
end
