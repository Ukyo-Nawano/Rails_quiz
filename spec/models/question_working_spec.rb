require "spec_helper"

RSpec.describe Question, type: :model do
  before do
    # テスト環境を強制的に設定
    allow(Rails.env).to receive(:test?).and_return(true)
  end

  describe "基本的な機能" do
    it "Questionモデルが存在する" do
      expect(Question).to be_a(Class)
    end

    it "quizに属している" do
      question = Question.new
      expect(question).to respond_to(:quiz)
    end

    it "choicesを持っている" do
      question = Question.new
      expect(question).to respond_to(:choices)
    end

    it "pointに属している" do
      question = Question.new
      expect(question).to respond_to(:point)
    end

    it "user_questionsを持っている" do
      question = Question.new
      expect(question).to respond_to(:user_questions)
    end
  end

  describe "バリデーション" do
    context "content" do
      it "contentが存在しない場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: nil)
        expect(question).not_to be_valid
        expect(question.errors[:content]).to include("can't be blank")
      end

      it "contentが空文字の場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: '')
        expect(question).not_to be_valid
        expect(question.errors[:content]).to include("can't be blank")
      end

      it "contentが1文字の場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: 'a')
        expect(question).to be_valid
      end

      it "contentが50文字の場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: 'a' * 50)
        expect(question).to be_valid
      end

      it "contentが50文字を超える場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: 'a' * 51)
        expect(question).not_to be_valid
        expect(question.errors[:content]).to include('is too long (maximum is 50 characters)')
      end
    end

    context "supplement" do
      it "supplementが空の場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: 'テスト問題', supplement: '')
        expect(question).to be_valid
      end

      it "supplementが50文字の場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: 'テスト問題', supplement: 'a' * 50)
        expect(question).to be_valid
      end

      it "supplementが50文字を超える場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        point = Point.create!(point: 10)
        
        question = Question.new(quiz: quiz, point: point, content: 'テスト問題', supplement: 'a' * 51)
        expect(question).not_to be_valid
        expect(question.errors[:supplement]).to include('is too long (maximum is 50 characters)')
      end
    end

    context "point_id" do
      it "point_idが存在しない場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        question = Question.new(quiz: quiz, content: 'テスト問題', point: nil)
        expect(question).not_to be_valid
        expect(question.errors[:point_id]).to include('を選択してください')
      end
    end
  end

  describe "ネストした属性" do
    it "choicesのネストした属性を受け入れる" do
      expect(Question.new).to respond_to(:choices_attributes=)
    end
  end
end
