class Question < ApplicationRecord
    has_many :choices, dependent: :destroy
    belongs_to :quiz
end
