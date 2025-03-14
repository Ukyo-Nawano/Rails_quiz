class Choice < ApplicationRecord
    belongs_to :question

    validates :name, presence: true
    validates :is_valid, inclusion: { in: [true, false] }
      
    # 正解選択肢を設定
    scope :correct, -> { where(is_valid: true) }
end