FactoryBot.define do 
  factory :user do
    name "name"
    sequence(:email) { |n| "email#{n}@email.com" }
    password "password"
    password_confirmation "password"
  end
end