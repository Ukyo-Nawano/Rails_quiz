class Choice < ApplicationRecord
    belongs_to :quiz, foreign_key: :question_id
end
