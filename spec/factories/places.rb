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
    # association :tag
    # trait :place_with_tags do
    #   after(:build) do |place|
    #     FactoryBot.create(:tag_map, place: place, tag: FactoryBot.create(:tag))
    #   end
    # end
  end
end
