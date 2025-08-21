FactoryBot.define do
  factory :quiz do
    sequence(:title) { |n| "クイズ#{n}" }
    description { "テスト用のクイズです" }
    association :user
    
    after(:build) do |quiz|
      # タグを追加
      tag = create(:tag)
      quiz.tag_ids = [tag.id]
      
      # テスト用の画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
  
  factory :quiz_with_questions, parent: :quiz do
    after(:create) do |quiz|
      # 問題を追加
      create(:question, quiz: quiz)
    end
  end
end