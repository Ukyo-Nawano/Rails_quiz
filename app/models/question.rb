class Question < ApplicationRecord
    has_many :choices, dependent: :destroy
    belongs_to :quiz
    belongs_to :point, optional: true
    accepts_nested_attributes_for :choices, allow_destroy: true
    has_many :user_questions
    validates :content, presence: true, length: { minimum: 1, maximum: 50 }
    validates :supplement, length: { minimum: 1, maximum: 50 }, allow_blank: true
    validates :point_id, presence: { message: "を選択してください" }
    validate :validate_choices
    validate :validate_correct_choice
  
    def validate_choices
      if choices.length < 2
        errors.add(:choices, "は2つ以上必要です")
      end
      if choices.any? { |choice| choice.name.blank? || choice.name.length > 50 }
        errors.add(:choices, "の内容は1文字以上50文字以内で入力してください")
      end
    end
  
    def validate_correct_choice
      if choices.none?(&:is_valid)
        errors.add(:correct_choice, "を1つ選択してください")
      end
    end
  end
  