FactoryBot.define do
    factory :course do
        name { Faker::Course }
        description { Faker::Yoda.quote }
        url { Faker::Internet.url }
        course_type { Faker::Course }
        commitment { Faker::Commitment }
        hours_per_week { Faker::Number.between(40, 60) }
        start_date {Faker::Date.forward(150) }
        class_size { Faker::Number.between(5, 30) }
        duration_in_weeks { Faker::Number.between(9, 24) }
    end
end
