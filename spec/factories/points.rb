FactoryBot.define do
  factory :point do
    sequence(:point) { |n| n * 10 }
  end
end