class Quiz < ApplicationRecord
    has_many :choices, foreign_key: :question_id
end
