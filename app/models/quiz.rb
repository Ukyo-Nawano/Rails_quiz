class Quiz < ApplicationRecord
    belongs_to :user
    has_many :questions, dependent: :destroy
    has_many :tag_quizzes, dependent: :destroy
    has_many :tags, through: :tag_quizzes
end
