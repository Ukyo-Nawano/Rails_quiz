class Quiz < ApplicationRecord
    belongs_to :user
    has_many :questions, dependent: :destroy
    has_many :tag_quizzes, dependent: :destroy
    has_many :tags, through: :tag_quizzes
    has_many :favorites, dependent: :destroy
    has_one_attached :image
    def image_filename
        image.attached? ? image.filename.to_s : nil
    end
    accepts_nested_attributes_for :questions, allow_destroy: true
    validates :tag_ids, presence: { message: "を1つ以上選択してください" }
    # validates :title, presence: true, length: { minimum: 1, maximum: 50 }
    validates :description, length: { maximum: 500 }, allow_blank: true
    validates :image, presence: { message: "をアップロードしてください" }, on: :create
    validates :questions, length: { minimum: 1, message: "を1問以上追加してください" }
end
