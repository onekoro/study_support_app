FactoryBot.define do
  factory :relationship, aliases: [:active_relationship, :passive_relationship] do
    association :follower,
      factory: :user
    association :followed,
      factory: :user
  end
end
