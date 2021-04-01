FactoryBot.define do 
  factory :user do
    name "name"
    sequence(:email) { |n| "email#{n}@email.com" }
    password "password"
    admin false
  end
end