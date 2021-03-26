FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "content#{n}" }
    recommend 3
    association :user
    association :place
  end
end
