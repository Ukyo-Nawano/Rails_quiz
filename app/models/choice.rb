class Choice < ApplicationRecord
    belongs_to :question

    validates :name, presence: true
end