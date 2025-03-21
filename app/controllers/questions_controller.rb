class QuestionsController < ApplicationController
    def index
        @quiz = Quiz.find(params[:quiz_id])
        @questions = @quiz.questions.includes(:choices)
        @user = current_user
        @current_score = @user.total_points if @user

        # 特定の設問を表示するためのロジックを追加
        if params[:question_id]
            @current_question = Question.find(params[:question_id])
        end
    end


    def answer
        @question = Question.find(params[:id])
        @user = current_user # ユーザー情報を取得

        # ユーザーの回答を取得
        @user_question = UserQuestion.where(user_id: @user.id, question_id: @question.id).order(created_at: :desc).first

        @user_answer = @user_question.result # user_questionsテーブルのresultカラムの値を取得

        @explanation = @question.supplement # 質問の解説を取得
        Rails.logger.debug("User Questionだよ: #{@user_question}")
        Rails.logger.debug("User Answerだよ: #{@user_question.result}")

        # answer.html.erb ビューを表示
        render 'answer'
    end

    def confirm_destroy
        @question = Question.find(params[:id])
        @quiz = @question.quiz # 削除する設問が属するクイズを取得
    end

    def destroy
        @question = Question.find(params[:id])
        quiz = @question.quiz # 削除する設問が属するクイズを取得

        if @question.destroy
            # 削除後にクイズ内の設問が残っているか確認
            if quiz.questions.count == 0
                quiz.destroy # 設問が残っていなければクイズを削除
                redirect_to quizzes_path, notice: 'クイズが削除されました！'
            else
                redirect_to quizzes_path, notice: '質問が削除されました！'
            end
        else
            redirect_to quizzes_path, alert: '質問の削除に失敗しました。'
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

    def show
        @question = Question.find(params[:id]) # ここで質問を取得
        @user = current_user # ユーザー情報を取得
        @quiz = Quiz.find(params[:quiz_id])
        @questions = @quiz.questions.includes(:choices)
        @current_score = @user.total_points if @user
        @quiz_questions = @question.quiz.questions
        @question_index = @quiz_questions.index(@question) + 1 # 1から始まる番号にするために +1

        # 特定の設問を表示するためのロジックを追加
        if params[:question_id]
            @current_question = Question.find(params[:question_id])
        end
    end

    def result
        @quiz = Quiz.find(params[:quiz_id])
        @user = current_user

        @user_questions = UserQuestion.where(user_id: @user.id, question_id: @quiz.questions.pluck(:id))
                                      .order(created_at: :desc)
                                      .limit(@quiz.questions.count)

        # resultがtrueのものの数をカウント
        @correct_answers = @user_questions.select(:result).count { |uq| uq.result == true }

        # 総設問数を取得
        @total_questions = @quiz.questions.count

        Rails.logger.debug("User Questions: #{@user_questions.inspect}")
        Rails.logger.debug("Correct Answers Count: #{@correct_answers_count}")

        # 最初の設問を取得
        @first_question = @quiz.questions.first
    end

    private

    def question_params
        params.require(:question).permit(
            :content, :supplement,
            choices_attributes: [:id, :name, :is_valid, :_destroy]
        )
    end
end
