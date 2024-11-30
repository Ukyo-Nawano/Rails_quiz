class QuizzesController < ApplicationController
    def index
        @quizzes = Quiz.includes(:choices).all
        # session[:userinfo]の内容をログに出力
        Rails.logger.debug("session[:userinfo]: #{session[:userinfo].inspect}")
        @user = session[:userinfo]
    end
    include Secured

    def show

    end
  
    def new
    end
  
    def edit
    end
  
    def create
    end
  
    def update
    end
  
    def destroy
    end
end
