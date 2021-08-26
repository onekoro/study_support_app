FactoryBot.define do 
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "email#{n}@email.com" }
    password { |n| "password#{n}" }
    admin { false }
    
    trait :invalid do
      name { nil }
    end
  end
end