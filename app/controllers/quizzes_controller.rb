class QuizzesController < ApplicationController
    def index
        @quizzes = Quiz.all
        Rails.logger.debug("session[:userinfo]: #{session[:userinfo].inspect}")
        @user = session[:userinfo]
        @users = User.all
    end
    include Secured

    def overview
        @quiz = Quiz.find(params[:id])
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
          :title, :description, :image,
          questions_attributes: [
            :content, :supplement, :_destroy,
            choices_attributes: [:name, :is_valid, :_destroy]
          ]
        )
    end


    def edit
    end
  
    def update
    end
  
    def destroy
    end
end
