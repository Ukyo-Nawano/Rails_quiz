FactoryBot.define do
  factory :question do
    sequence(:content) { |n| "問題#{n}" }
    supplement { "解説です" }
    association :quiz
    association :point
  end
end