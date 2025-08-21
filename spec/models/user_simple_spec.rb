require "spec_helper"

RSpec.describe User, type: :model do
  describe "基本的な機能" do
    it "Userモデルが存在する" do
      expect(User).to be_a(Class)
    end

    it "name属性を持つ" do
      user = User.new
      expect(user).to respond_to(:name)
    end

    it "email属性を持つ" do
      user = User.new
      expect(user).to respond_to(:email)
    end

    it "nickname属性を持つ" do
      user = User.new
      expect(user).to respond_to(:nickname)
    end
  end

  describe "データベース操作" do
    it "有効なユーザーを作成できる" do
      user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
      expect(user).to be_persisted
      expect(user.name).to eq("テストユーザー")
      expect(user.email).to eq("test@example.com")
      expect(user.nickname).to eq("test")
    end
  end

  describe "アソシエーション" do
    it "quizzesを持っている" do
      user = User.new
      expect(user).to respond_to(:quizzes)
    end

    it "favoritesを持っている" do
      user = User.new
      expect(user).to respond_to(:favorites)
    end

    it "favorite_quizzesを持っている" do
      user = User.new
      expect(user).to respond_to(:favorite_quizzes)
    end
  end

  describe "カスタムメソッド" do
    describe "#total_points" do
      it "基本的なtotal_pointsメソッドが存在する" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        expect(user).to respond_to(:total_points)
      end

      it "新規ユーザーのtotal_pointsは0である" do
        user = User.create!(name: "テストユーザー", email: "test@example.com", nickname: "test")
        expect(user.total_points).to eq(0)
      end
    end
  end
end
