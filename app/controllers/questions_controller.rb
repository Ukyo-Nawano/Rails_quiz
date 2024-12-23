class QuestionsController < ApplicationController
    def index
        @quiz = Quiz.find(params[:quiz_id])
        @questions = @quiz.questions.includes(:choices)
    end

    def destroy
        @quiz = Quiz.find(params[:quiz_id])
        @question = @quiz.questions.find(params[:id])

        if @question.destroy
            render json: { message: '設問が削除されました。' }, status: :ok
        else
            render json: { error: '設問の削除に失敗しました。' }, status: :unprocessable_entity
        end
    end
end
