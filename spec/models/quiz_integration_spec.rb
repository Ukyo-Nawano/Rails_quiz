require "spec_helper"

RSpec.describe "Quiz統合テスト", type: :model do
  before do
    # テスト環境を強制的に設定
    allow(Rails.env).to receive(:test?).and_return(true)
  end

  describe "QuizとQuestionの連携" do
    it "QuizにQuestionを追加できる" do
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
      question = Question.create!(content: "テスト問題", quiz: quiz, point: point)
      
      expect(quiz.questions).to include(question)
      expect(question.quiz).to eq(quiz)
    end

    it "Quizを削除すると関連するQuestionも削除される" do
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
      question = Question.create!(content: "テスト問題", quiz: quiz, point: point)
      
      question_id = question.id
      quiz.destroy
      
      expect(Question.find_by(id: question_id)).to be_nil
    end

    it "ネストした属性でQuestionを作成できる" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag = Tag.create!(tag: "テストタグ")
      point = Point.create!(point: 10)
      
      quiz = Quiz.new(user: user, tag_ids: [tag.id])
      
      # 画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      
      quiz.questions_attributes = [
        { content: "問題1", point: point },
        { content: "問題2", point: point }
      ]
      
      quiz.save!
      
      expect(quiz.questions.count).to eq(2)
      expect(quiz.questions.pluck(:content)).to include("問題1", "問題2")
    end
  end

  describe "QuestionとChoiceの連携" do
    it "QuestionにChoiceを追加できる" do
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
      question = Question.create!(content: "テスト問題", quiz: quiz, point: point)
      
      choice1 = Choice.create!(name: "選択肢1", question: question, is_valid: true)
      choice2 = Choice.create!(name: "選択肢2", question: question, is_valid: false)
      
      expect(question.choices.count).to eq(2)
      expect(question.choices).to include(choice1, choice2)
      expect(choice1.question).to eq(question)
    end

    it "Questionを削除すると関連するChoiceも削除される" do
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
      question = Question.create!(content: "テスト問題", quiz: quiz, point: point)
      
      choice = Choice.create!(name: "選択肢", question: question)
      choice_id = choice.id
      
      question.destroy
      
      expect(Choice.find_by(id: choice_id)).to be_nil
    end

    it "ネストした属性でChoiceを作成できる" do
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
      question = quiz.questions.create!(content: "テスト問題", point: point)
      
      question.choices_attributes = [
        { name: "選択肢1", is_valid: true },
        { name: "選択肢2", is_valid: false },
        { name: "選択肢3", is_valid: false }
      ]
      
      question.save!
      
      expect(question.choices.count).to eq(3)
      expect(question.choices.where(is_valid: true).count).to eq(1)
      expect(question.choices.where(is_valid: false).count).to eq(2)
    end
  end

  describe "QuizとTagの連携" do
    it "Quizに複数のTagを設定できる" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      tag1 = Tag.create!(tag: "タグ1")
      tag2 = Tag.create!(tag: "タグ2")
      tag3 = Tag.create!(tag: "タグ3")
      
      quiz = Quiz.new(user: user, tag_ids: [tag1.id, tag2.id, tag3.id])
      
      # 画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      
      quiz.save!
      
      expect(quiz.tags.count).to eq(3)
      expect(quiz.tags).to include(tag1, tag2, tag3)
    end

    it "Tagを削除してもQuizは削除されない" do
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
      quiz_id = quiz.id
      tag.destroy
      
      expect(Quiz.find_by(id: quiz_id)).to be_present
      expect(quiz.reload.tags).to be_empty
    end
  end

  describe "完全なQuiz作成フロー" do
    it "ユーザー、タグ、問題、選択肢を含む完全なQuizを作成できる" do
      # ユーザー作成
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      
      # タグ作成
      tag1 = Tag.create!(tag: "プログラミング")
      tag2 = Tag.create!(tag: "Ruby")
      
      # ポイント作成
      point1 = Point.create!(point: 10)
      point2 = Point.create!(point: 20)
      
      # Quiz作成
      quiz = Quiz.new(user: user, tag_ids: [tag1.id, tag2.id])
      
      # 画像を添付
      quiz.image.attach(
        io: StringIO.new("dummy image content"),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      
      quiz.save!
      
      # 問題1作成
      question1 = quiz.questions.create!(content: "Rubyの特徴は？", point: point1)
      question1.choices.create!(name: "動的型付け", is_valid: true)
      question1.choices.create!(name: "静的型付け", is_valid: false)
      question1.choices.create!(name: "コンパイル言語", is_valid: false)
      
      # 問題2作成
      question2 = quiz.questions.create!(content: "Railsの特徴は？", point: point2)
      question2.choices.create!(name: "MVCアーキテクチャ", is_valid: true)
      question2.choices.create!(name: "MVVMアーキテクチャ", is_valid: false)
      question2.choices.create!(name: "マイクロサービス", is_valid: false)
      
      # 検証
      expect(quiz.user).to eq(user)
      expect(quiz.tags.count).to eq(2)
      expect(quiz.questions.count).to eq(2)
      expect(quiz.questions.first.choices.count).to eq(3)
      expect(quiz.questions.last.choices.count).to eq(3)
      expect(quiz.questions.first.choices.where(is_valid: true).count).to eq(1)
      expect(quiz.questions.last.choices.where(is_valid: true).count).to eq(1)
    end
  end
end
