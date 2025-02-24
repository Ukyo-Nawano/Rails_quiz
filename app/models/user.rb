class User < ApplicationRecord
    has_many :quizzes

    def total_points
        UserQuestion.joins(question: :point)
                    .where(user_id: id, result: true, is_first: true)
                    .sum('points.point') # pointsテーブルのpointカラムを合計
    end
end
