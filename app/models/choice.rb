class Choice < ApplicationRecord
    belongs_to :quizzes, foreign_key: :question_id
end
