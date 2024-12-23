class QuestionsController < ApplicationController
    def index
        @quiz = Quiz.find(params[:quiz_id])
        @questions = @quiz.questions.includes(:choices)
    end
end
