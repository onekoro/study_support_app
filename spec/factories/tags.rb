FactoryBot.define do
  factory :tag do
    sequence(:tag_name) { |n| "tag#{n}" }
    association :place
  end
end
