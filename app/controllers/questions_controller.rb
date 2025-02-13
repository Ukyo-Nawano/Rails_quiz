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

    def update
        @quiz = Quiz.find(params[:quiz_id])
        @question = @quiz.questions.find(params[:id])
        Rails.logger.debug("Received: #{params.inspect}")
        if @question.update(question_params)
            render json: { message: '設問が更新されました。' }, status: :ok
        else
            render json: { error: '設問の更新に失敗しました。' }, status: :unprocessable_entity
        end
    end

    private

    def question_params
        params.require(:question).permit(
            :content, :supplement,
            choices_attributes: [:id, :name, :is_valid, :_destroy]
        )
    end
end
