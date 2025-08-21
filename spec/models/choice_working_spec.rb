require "spec_helper"

RSpec.describe Choice, type: :model do
  describe "基本的な機能" do
    it "Choiceモデルが存在する" do
      expect(Choice).to be_a(Class)
    end

    it "questionに属している" do
      choice = Choice.new
      expect(choice).to respond_to(:question)
    end
  end

  describe "バリデーション" do
    context "name" do
      it "nameが存在しない場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user)
        point = Point.create!(point: 10)
        question = Question.new(content: "テスト問題", quiz: quiz, point: point)
        
        choice = Choice.new(name: nil, question: question)
        expect(choice).not_to be_valid
        expect(choice.errors[:name]).to include("can't be blank")
      end

      it "nameが空文字の場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user)
        point = Point.create!(point: 10)
        question = Question.new(content: "テスト問題", quiz: quiz, point: point)
        
        choice = Choice.new(name: '', question: question)
        expect(choice).not_to be_valid
        expect(choice.errors[:name]).to include("can't be blank")
      end

      it "nameが存在する場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user)
        point = Point.create!(point: 10)
        question = Question.new(content: "テスト問題", quiz: quiz, point: point)
        
        choice = Choice.new(name: '選択肢', question: question)
        expect(choice).to be_valid
      end

      it "nameが長い文字列でも有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user)
        point = Point.create!(point: 10)
        question = Question.new(content: "テスト問題", quiz: quiz, point: point)
        
        choice = Choice.new(name: 'a' * 100, question: question)
        expect(choice).to be_valid
      end
    end

    context "is_valid" do
      it "is_validがtrueの場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user)
        point = Point.create!(point: 10)
        question = Question.new(content: "テスト問題", quiz: quiz, point: point)
        
        choice = Choice.new(name: '選択肢', question: question, is_valid: true)
        expect(choice).to be_valid
      end

      it "is_validがfalseの場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user)
        point = Point.create!(point: 10)
        question = Question.new(content: "テスト問題", quiz: quiz, point: point)
        
        choice = Choice.new(name: '選択肢', question: question, is_valid: false)
        expect(choice).to be_valid
      end

      it "is_validがnilの場合、有効である（デフォルトでfalseになる）" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user)
        point = Point.create!(point: 10)
        question = Question.new(content: "テスト問題", quiz: quiz, point: point)
        
        choice = Choice.new(name: '選択肢', question: question, is_valid: nil)
        expect(choice).to be_valid
      end
    end
  end

  describe "デフォルト値" do
    it "is_validのデフォルト値はfalseである" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      quiz = Quiz.new(user: user)
      point = Point.create!(point: 10)
      question = Question.new(content: "テスト問題", quiz: quiz, point: point)
      
      choice = Choice.new(name: 'テスト選択肢', question: question)
      expect(choice.is_valid).to be_falsey
    end
  end
end

