class Choice < ApplicationRecord
    belongs_to :question

    validates :name, presence: true
    validates :is_valid, inclusion: { in: [true, false] }
end