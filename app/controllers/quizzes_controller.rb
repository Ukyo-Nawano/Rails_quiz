class QuizzesController < ApplicationController
    def index
        @quizzes = Quiz.all
        @user = current_user # 現在のユーザーを取得
        @current_score = @user.total_points if @user # ユーザーが存在する場合にポイントを計算
        Rails.logger.debug("session[:userinfo]: #{session[:userinfo].inspect}")
        @users = User.all
    end
    include Secured

    def overview
        @quiz = Quiz.find(params[:id])
        @is_owner = @quiz.user_id == current_user.id
    end

    def show

    end

    def new
        @quiz = Quiz.new
        @quiz.questions.build.choices.build  # クイズ作成時に質問と選択肢のフォームを用意
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

    def quiz_params
    params.require(:quiz).permit(
    :title,
    :description,
    :image,
    questions_attributes: [
        :id,
        :content,
        :supplement,
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


    def edit
        @quiz = Quiz.find(params[:id])
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
        @quiz = Quiz.find(params[:id])
        @quiz.update(deleted_at: Time.current)
        redirect_to quizzes_path, notice: 'クイズが削除されました！'
    end
end
