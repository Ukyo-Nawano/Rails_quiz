FactoryBot.define do
  factory :choice do
    sequence(:name) { |n| "選択肢#{n}" }
    is_valid { false }
    association :question
  end
end