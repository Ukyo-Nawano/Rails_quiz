FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "ユーザー#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:nickname) { |n| "nickname#{n}" }
    image { "https://example.com/avatar.jpg" }
  end
end