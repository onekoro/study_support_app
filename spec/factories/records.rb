FactoryBot.define do
  factory :record do
    date { "2021-04-10" }
    hour { 1 }
    minute { 1 }
    association :user
    association :place
    
  end
end
