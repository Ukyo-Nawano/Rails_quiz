require "spec_helper"

RSpec.describe "User統合テスト", type: :model do
  before do
    # テスト環境を強制的に設定
    allow(Rails.env).to receive(:test?).and_return(true)
  end

  describe "UserとQuizの関係" do
    it "ユーザーが複数のQuizを作成できる" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag1 = Tag.create!(tag: "プログラミング")
      tag2 = Tag.create!(tag: "数学")
      
      # Quiz1作成
      quiz1 = Quiz.new(user: user, tag_ids: [tag1.id])
      quiz1.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'quiz1.png',
        content_type: 'image/png'
      )
      quiz1.save!
      
      # Quiz2作成
      quiz2 = Quiz.new(user: user, tag_ids: [tag2.id])
      quiz2.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'quiz2.png',
        content_type: 'image/png'
      )
      quiz2.save!
      
      expect(user.quizzes.count).to eq(2)
      expect(user.quizzes).to include(quiz1, quiz2)
      expect(quiz1.user).to eq(user)
      expect(quiz2.user).to eq(user)
    end

    it "ユーザーを削除しても関連するQuizは削除されない" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      
      quiz = Quiz.new(user: user, tag_ids: [tag.id])
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      quiz_id = quiz.id
      user.destroy
      
      # Userを削除してもQuizは削除されない（dependent: :destroyが設定されていないため）
      expect(Quiz.find_by(id: quiz_id)).to be_present
      expect(Quiz.find_by(id: quiz_id).user_id).to eq(user.id)
    end
  end

  describe "UserとFavoriteの関係" do
    it "ユーザーが他のユーザーのQuizをお気に入りにできる" do
      # 作成者ユーザー
      creator = User.create!(name: "作成者", email: "creator@example.com", nickname: "creator")
      # お気に入り登録するユーザー
      favoriter = User.create!(name: "お気に入り登録者", email: "favoriter@example.com", nickname: "favoriter")
      
      tag = Tag.create!(tag: "テストタグ")
      quiz = Quiz.new(user: creator, tag_ids: [tag.id])
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      favorite = Favorite.create!(user: favoriter, quiz: quiz)
      
      expect(favoriter.favorites.count).to eq(1)
      expect(favoriter.favorite_quizzes).to include(quiz)
      expect(quiz.favorites.count).to eq(1)
      expect(quiz.favorites.first.user).to eq(favoriter)
    end

    it "複数のユーザーが同じQuizをお気に入りにできる" do
      creator = User.create!(name: "作成者", email: "creator@example.com", nickname: "creator")
      user1 = User.create!(name: "ユーザー1", email: "user1@example.com", nickname: "user1")
      user2 = User.create!(name: "ユーザー2", email: "user2@example.com", nickname: "user2")
      user3 = User.create!(name: "ユーザー3", email: "user3@example.com", nickname: "user3")
      
      tag = Tag.create!(tag: "テストタグ")
      quiz = Quiz.new(user: creator, tag_ids: [tag.id])
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      Favorite.create!(user: user1, quiz: quiz)
      Favorite.create!(user: user2, quiz: quiz)
      Favorite.create!(user: user3, quiz: quiz)
      
      expect(quiz.favorites.count).to eq(3)
      expect(quiz.favorites.pluck(:user_id)).to include(user1.id, user2.id, user3.id)
    end

    it "お気に入りを削除できる" do
      creator = User.create!(name: "作成者", email: "creator@example.com", nickname: "creator")
      favoriter = User.create!(name: "お気に入り登録者", email: "favoriter@example.com", nickname: "favoriter")
      
      tag = Tag.create!(tag: "テストタグ")
      quiz = Quiz.new(user: creator, tag_ids: [tag.id])
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      favorite = Favorite.create!(user: favoriter, quiz: quiz)
      favorite_id = favorite.id
      
      favorite.destroy
      
      expect(Favorite.find_by(id: favorite_id)).to be_nil
      expect(favoriter.favorite_quizzes).not_to include(quiz)
    end
  end

  describe "UserのQuiz作成とお気に入り登録の統合" do
    it "ユーザーがQuizを作成し、他のユーザーがお気に入り登録する完全なフロー" do
      # 作成者
      creator = User.create!(name: "作成者", email: "creator@example.com", nickname: "creator")
      # お気に入り登録者
      favoriter1 = User.create!(name: "お気に入り1", email: "favoriter1@example.com", nickname: "favoriter1")
      favoriter2 = User.create!(name: "お気に入り2", email: "favoriter2@example.com", nickname: "favoriter2")
      
      # タグ作成
      tag1 = Tag.create!(tag: "プログラミング")
      tag2 = Tag.create!(tag: "Ruby")
      
      # ポイント作成
      point = Point.create!(point: 15)
      
      # Quiz作成
      quiz = Quiz.new(user: creator, tag_ids: [tag1.id, tag2.id])
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test.png',
        content_type: 'image/png'
      )
      quiz.save!
      
      # 問題作成
      question = quiz.questions.create!(content: "Rubyの特徴は？", point: point)
      question.choices.create!(name: "動的型付け", is_valid: true)
      question.choices.create!(name: "静的型付け", is_valid: false)
      question.choices.create!(name: "コンパイル言語", is_valid: false)
      
      # お気に入り登録
      Favorite.create!(user: favoriter1, quiz: quiz)
      Favorite.create!(user: favoriter2, quiz: quiz)
      
      # 検証
      expect(creator.quizzes.count).to eq(1)
      expect(creator.quizzes.first).to eq(quiz)
      expect(quiz.favorites.count).to eq(2)
      expect(quiz.favorites.pluck(:user_id)).to include(favoriter1.id, favoriter2.id)
      expect(favoriter1.favorite_quizzes).to include(quiz)
      expect(favoriter2.favorite_quizzes).to include(quiz)
      expect(quiz.questions.count).to eq(1)
      expect(quiz.questions.first.choices.count).to eq(3)
    end
  end

  describe "Userの統計情報" do
    it "ユーザーのQuiz作成数とお気に入り登録数を取得できる" do
      creator = User.create!(name: "作成者", email: "creator@example.com", nickname: "creator")
      favoriter = User.create!(name: "お気に入り登録者", email: "favoriter@example.com", nickname: "favoriter")
      
      tag = Tag.create!(tag: "テストタグ")
      
      # 3つのQuizを作成
      3.times do |i|
        quiz = Quiz.new(user: creator, tag_ids: [tag.id])
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: "quiz#{i}.png",
          content_type: 'image/png'
        )
        quiz.save!
      end
      
      # 2つのQuizをお気に入りに登録
      creator.quizzes.limit(2).each do |quiz|
        Favorite.create!(user: favoriter, quiz: quiz)
      end
      
      expect(creator.quizzes.count).to eq(3)
      expect(favoriter.favorites.count).to eq(2)
      expect(favoriter.favorite_quizzes.count).to eq(2)
    end
  end
end
