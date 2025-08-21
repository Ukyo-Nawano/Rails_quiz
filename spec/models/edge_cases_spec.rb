require "spec_helper"

RSpec.describe "エッジケースと境界値テスト", type: :model do
  before do
    # テスト環境を強制的に設定
    allow(Rails.env).to receive(:test?).and_return(true)
  end

  describe "文字数制限の境界値テスト" do
    context "Quizのdescription" do
      it "descriptionが500文字ちょうどの場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id], description: 'a' * 500)
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        
        expect(quiz).to be_valid
      end

      it "descriptionが501文字の場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id], description: 'a' * 501)
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        
        expect(quiz).not_to be_valid
        expect(quiz.errors[:description]).to include('is too long (maximum is 500 characters)')
      end

      it "descriptionが0文字の場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id], description: '')
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        
        expect(quiz).to be_valid
      end
    end

    context "Questionのcontent" do
      it "contentが50文字ちょうどの場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        quiz.save!
        
        point = Point.create!(point: 10)
        question = Question.new(quiz: quiz, point: point, content: 'a' * 50)
        
        expect(question).to be_valid
      end

      it "contentが51文字の場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        quiz.save!
        
        point = Point.create!(point: 10)
        question = Question.new(quiz: quiz, point: point, content: 'a' * 51)
        
        expect(question).not_to be_valid
        expect(question.errors[:content]).to include('is too long (maximum is 50 characters)')
      end

      it "contentが1文字の場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        quiz.save!
        
        point = Point.create!(point: 10)
        question = Question.new(quiz: quiz, point: point, content: 'a')
        
        expect(question).to be_valid
      end
    end

    context "Questionのsupplement" do
      it "supplementが50文字ちょうどの場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        quiz.save!
        
        point = Point.create!(point: 10)
        question = Question.new(quiz: quiz, point: point, content: 'テスト問題', supplement: 'a' * 50)
        
        expect(question).to be_valid
      end

      it "supplementが51文字の場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        quiz.save!
        
        point = Point.create!(point: 10)
        question = Question.new(quiz: quiz, point: point, content: 'テスト問題', supplement: 'a' * 51)
        
        expect(question).not_to be_valid
        expect(question.errors[:supplement]).to include('is too long (maximum is 50 characters)')
      end
    end
  end

  describe "特殊文字とエンコーディング" do
    it "日本語、英語、記号を含むcontentが有効である" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      quiz = Quiz.new(user: user, tag_ids: [tag.id])
      
      # 画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      point = Point.create!(point: 10)
      content = "Rubyの特徴は？\n1. 動的型付け\n2. 静的型付け\n3. コンパイル言語"
      question = Question.new(quiz: quiz, point: point, content: content)
      
      expect(question).to be_valid
    end

    it "絵文字を含むcontentが有効である" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      quiz = Quiz.new(user: user, tag_ids: [tag.id])
      
      # 画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      point = Point.create!(point: 10)
      content = "プログラミング 🚀 楽しい！"
      question = Question.new(quiz: quiz, point: point, content: content)
      
      expect(question).to be_valid
    end
  end

  describe "大量データの処理" do
    it "大量のQuizを作成できる" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      point = Point.create!(point: 10)
      
      # 10個のQuizを作成
      10.times do |i|
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: "quiz#{i}.png",
          content_type: 'image/png'
        )
        quiz.save!
        
        # 各Quizに3つの問題を作成
        3.times do |j|
          question = quiz.questions.create!(content: "問題#{i}-#{j}", point: point)
          question.choices.create!(name: "選択肢1", is_valid: true)
          question.choices.create!(name: "選択肢2", is_valid: false)
          question.choices.create!(name: "選択肢3", is_valid: false)
        end
      end
      
      expect(user.quizzes.count).to eq(10)
      expect(user.quizzes.joins(:questions).count).to eq(30)
      expect(Choice.joins(question: :quiz).where(quizzes: { user: user }).count).to eq(90)
    end
  end

  describe "データの整合性" do
    it "同じユーザーが同じQuizを複数回お気に入りに登録できない" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      quiz = Quiz.new(user: user, tag_ids: [tag.id])
      
      # 画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      # 1回目のお気に入り登録
      Favorite.create!(user: user, quiz: quiz)
      
      # 2回目のお気に入り登録（同じユーザーとQuizの組み合わせ）
      expect {
        Favorite.create!(user: user, quiz: quiz)
      }.to raise_error(ActiveRecord::RecordInvalid, /User has already been taken/)
    end

    it "存在しないユーザーIDでQuizを作成できない" do
      tag = Tag.create!(tag: "テストタグ")
      
      expect {
        Quiz.create!(user_id: 99999, tag_ids: [tag.id])
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "存在しないタグIDでQuizを作成できない" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      
      expect {
        Quiz.create!(user: user, tag_ids: [99999])
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "削除の整合性" do
    it "Quizを削除すると関連する全てのデータが削除される" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      point = Point.create!(point: 10)
      
      quiz = Quiz.new(user: user, tag_ids: [tag.id])
      
      # 画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      question = quiz.questions.create!(content: "テスト問題", point: point)
      choice = question.choices.create!(name: "選択肢", is_valid: true)
      
      # 他のユーザーがお気に入りに登録
      other_user = User.create!(name: "他のユーザー", email: "other@example.com", nickname: "other")
      favorite = Favorite.create!(user: other_user, quiz: quiz)
      
      quiz_id = quiz.id
      question_id = question.id
      choice_id = choice.id
      favorite_id = favorite.id
      
      quiz.destroy
      
      expect(Quiz.find_by(id: quiz_id)).to be_nil
      expect(Question.find_by(id: question_id)).to be_nil
      expect(Choice.find_by(id: choice_id)).to be_nil
      expect(Favorite.find_by(id: favorite_id)).to be_nil
    end
  end
end
