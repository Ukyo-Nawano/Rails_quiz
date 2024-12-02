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
