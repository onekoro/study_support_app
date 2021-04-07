FactoryBot.define do
  factory :place do
    sequence(:title) { |n| "title#{n}" }
    content "content"
    address "address"
    web "web.com"
    cost 500
    wifi "あり"
    recommend 3
    association :user
  end
end
