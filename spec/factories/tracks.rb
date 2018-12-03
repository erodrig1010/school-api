FactoryBot.define do
  factory :track do
    name { Faker::Track }
    url { Faker::Internet.url }
    school_id { nil }
  end
end
