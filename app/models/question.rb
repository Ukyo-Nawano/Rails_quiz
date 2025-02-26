class Question < ApplicationRecord
    has_many :choices, dependent: :destroy
    belongs_to :quiz
    belongs_to :point, optional: true
    accepts_nested_attributes_for :choices, allow_destroy: true
    has_many :user_questions
end
