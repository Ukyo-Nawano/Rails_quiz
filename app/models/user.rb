class User < ApplicationRecord
    has_many :quizzes

    def current_score
        UserQuestion.joins(question: :point)
                    .where(user_id: id)
                    .sum('points.point') # pointsテーブルのvalueカラムを合計
    end
end
