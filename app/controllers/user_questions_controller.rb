class UserQuestionsController < ApplicationController
  def create
    user_question = UserQuestion.new(user_question_params)

    if user_question.save
      render json: { status: 'success', user_question: user_question }, status: :created
    else
      Rails.logger.error(user_question.errors.full_messages) # エラーメッセージをログに出力
      render json: { status: 'error', errors: user_question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def current_score
    user_id = current_user.id # 現在のユーザーのIDを取得
    score = UserQuestion.joins(question: :point)
                        .where(user_id: user_id)
                        .sum('points.point') # pointsテーブルのvalueカラムを合計

    render json: { score: score }
  end

  private

  def user_question_params
    params.require(:user_question).permit(:user_id, :question_id, :result, :is_first)
  end
end
