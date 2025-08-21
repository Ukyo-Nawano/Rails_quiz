require "spec_helper"

RSpec.describe Quiz, type: :model do
  before do
    # テスト環境を強制的に設定
    allow(Rails.env).to receive(:test?).and_return(true)
  end

  describe "基本的な機能" do
    it "Quizモデルが存在する" do
      expect(Quiz).to be_a(Class)
    end

    it "userに属している" do
      quiz = Quiz.new
      expect(quiz).to respond_to(:user)
    end

    it "questionsを持っている" do
      quiz = Quiz.new
      expect(quiz).to respond_to(:questions)
    end

    it "tagsを持っている" do
      quiz = Quiz.new
      expect(quiz).to respond_to(:tags)
    end

    it "favoritesを持っている" do
      quiz = Quiz.new
      expect(quiz).to respond_to(:favorites)
    end

    it "画像を添付できる" do
      quiz = Quiz.new
      expect(quiz).to respond_to(:image)
    end
  end

  describe "バリデーション" do
    context "tag_ids" do
      it "tag_idsが空の場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        quiz = Quiz.new(user: user, tag_ids: [])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        
        expect(quiz).not_to be_valid
        expect(quiz.errors[:tag_ids]).to include('を1つ以上選択してください')
      end

      it "tag_idsが存在する場合、有効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        
        expect(quiz).to be_valid
      end
    end

    context "description" do
      it "descriptionが500文字以下の場合、有効である" do
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

      it "descriptionが500文字を超える場合、無効である" do
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
    end

    context "image" do
      it "作成時にimageが存在しない場合、無効である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        expect(quiz).not_to be_valid
        expect(quiz.errors[:image]).to include('をアップロードしてください')
      end
    end
  end

  describe "カスタムメソッド" do
    describe "#image_filename" do
      it "画像が添付されている場合、ファイル名を返す" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        # 画像を添付
        quiz.image.attach(
          io: StringIO.new("dummy image content"),
          filename: 'test_image.png',
          content_type: 'image/png'
        )
        
        expect(quiz.image_filename).to eq('test_image.png')
      end

      it "画像が添付されていない場合、nilを返す" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        tag = Tag.create!(tag: "テストタグ")
        quiz = Quiz.new(user: user, tag_ids: [tag.id])
        
        expect(quiz.image_filename).to be_nil
      end
    end
  end

  describe "ネストした属性" do
    it "questionsのネストした属性を受け入れる" do
      expect(Quiz.new).to respond_to(:questions_attributes=)
    end
  end
end
