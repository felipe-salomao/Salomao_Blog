FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email }
    password { "password123" }
    confirmed_at { Time.zone.now }

    trait :admin do
      admin { true }
    end
  end
end
