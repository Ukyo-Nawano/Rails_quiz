class UserQuestionsController < ApplicationController
  def create
    @user_question = UserQuestion.new(user_question_params)

    # ユーザーがすでに質問に回答したかどうかを確認
    if UserQuestion.where(user_id: @user_question.user_id, question_id: @user_question.question_id).exists?
      @user_question.is_first = false # 2回目以降はis_firstをfalseに設定
    else
      @user_question.is_first = true # 1回目はis_firstをtrueに設定
    end

    if @user_question.save
      redirect_to answer_quiz_question_path(@user_question.question.quiz_id, @user_question.question.id), notice: '回答が保存されました。'
    else
      Rails.logger.error(@user_question.errors.full_messages) # エラーメッセージをログに出力
      render :new
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
