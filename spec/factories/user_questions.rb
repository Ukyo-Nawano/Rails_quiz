FactoryBot.define do
  factory :user_question do
    association :user
    association :question
    result { true }
    is_first { true }
  end
end