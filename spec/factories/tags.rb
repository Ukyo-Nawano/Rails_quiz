FactoryBot.define do
  factory :tag do
    sequence(:tag) { |n| "タグ#{n}" }
  end
end