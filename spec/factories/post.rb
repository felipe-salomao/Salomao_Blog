FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post Title #{n}" }
    sequence(:description) { |n| "Post Description #{n}" }
    association :category
    association :user
  end
end
