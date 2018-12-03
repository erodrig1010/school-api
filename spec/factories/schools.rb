FactoryBot.define do
  factory :school do
    name { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
    source_url { Faker::Internet.url }
    etag { Faker::Number.decimal_part(15) }
    about { Faker::Yoda.quote }
    website { Faker::Internet.url }
    email { Faker::Internet.free_email(name = nil) }
    job_guarantee {Faker::Boolean.boolean(0.5) }
    gi_bill {Faker::Boolean.boolean(0.5) }
    job_assistance {Faker::Boolean.boolean(0.5) }
    licensing {Faker::Boolean.boolean(0.5) }
    housing {Faker::Boolean.boolean(0.5) }
    corporate_training {Faker::Boolean.boolean(0.5) }
    closed {Faker::Boolean.boolean(0.5) }
  end
end
