class Quiz < ApplicationRecord
    belongs_to :user
    has_many :questions, dependent: :destroy
    has_many :tag_quizzes, dependent: :destroy
    has_many :tags, through: :tag_quizzes
    has_one_attached :image
    def image_filename
        image.attached? ? image.filename.to_s : nil
    end
    accepts_nested_attributes_for :questions, allow_destroy: true
end
