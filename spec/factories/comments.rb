FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "content#{n}" }
    recommend Faker::Number.between(from: 1, to: 5) 
    association :user
    association :place
  end
end
