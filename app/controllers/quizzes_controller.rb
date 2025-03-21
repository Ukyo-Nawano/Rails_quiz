class QuizzesController < ApplicationController
    def index
        @quizzes = Quiz.includes(:tags, :user).all  # タグとユーザー情報をプリロード
        @favorite_quizzes = current_user.favorites.includes(:quiz).map(&:quiz)
        @user = current_user
        @current_score = @user.total_points if @user
        Rails.logger.debug("session[:userinfo]: #{session[:userinfo].inspect}")
        @users = User.all
        @my_quizzes = current_user.quizzes  # 自分が作成したクイズ
        @quizzes_with_is_first = @quizzes.order(created_at: :desc).map do |quiz|
            # ユーザーがそのクイズに回答したかどうかを判定
            is_first = UserQuestion.where(user_id: current_user.id, question: quiz.questions).empty?
            { quiz: quiz, is_first: is_first }
        end
        @favorite_quizzes_with_is_first = @favorite_quizzes.map do |quiz|
            is_first = UserQuestion.where(user_id: current_user.id, question: quiz.questions).empty?
            { quiz: quiz, is_first: is_first }
        end
        @my_quizzes_with_is_first = @my_quizzes.order(created_at: :desc).map do |quiz|
            is_first = UserQuestion.where(user_id: current_user.id, question: quiz.questions).empty?
            { quiz: quiz, is_first: is_first }
        end
    end
    include Secured

    def overview
        @quiz = Quiz.find(params[:id])
        @first_question = @quiz.questions.first # 最初の設問を取得
        @is_owner = current_user == @quiz.user # クイズのオーナーかどうかを判定
    end

    def show

    end

    def new
        @quiz = Quiz.new
        @quiz.questions.build.choices.build  # クイズ作成時に質問と選択肢のフォームを用意
        @points = Point.all
        @tags = Tag.all
    end
    
    def create
        @quiz = Quiz.new(quiz_params)
        @quiz.user_id = current_user.id  # ログインユーザーのIDを設定
    
        if @quiz.save
        redirect_to quizzes_path, notice: 'クイズが作成されました！'
        else
        render :new
        end
    end


    def edit
        @quiz = Quiz.find(params[:id])
        @available_points = Point.all
    end

    def update
        @quiz = Quiz.find(params[:id])
        # デバッグ用: 送信されたパラメータをログに出力
        Rails.logger.debug("Received params: #{params.inspect}")
        if @quiz.update(quiz_params)
            redirect_to quizzes_path, notice: 'クイズが更新されました！'
        else
            render :edit
        end
    end

    def destroy
        @quiz = Quiz.includes(questions: :choices).find(params[:id]) # 関連する設問と選択肢を含めて取得
        Rails.logger.debug("Deleting quiz: #{@quiz.inspect}")
        if @quiz.destroy
            Rails.logger.debug("Quiz deleted successfully")
            redirect_to quizzes_path, notice: 'クイズが削除されました！'
        else
            Rails.logger.debug("Failed to delete quiz")
            redirect_to quizzes_path, alert: 'クイズの削除に失敗しました。'
        end
    end

    def confirm_destroy
        @quiz = Quiz.find(params[:id])
    end

    def quiz_params
        params.require(:quiz).permit(
        :title,
        :description,
        :image,
        :tag_ids => [],
        questions_attributes: [
            :id,
            :content,
            :supplement,
            :point_id,
            :_destroy,
            choices_attributes: [
            :id,
            :name,
            :is_valid,
            :_destroy
            ]
        ]
        )
    end

end
