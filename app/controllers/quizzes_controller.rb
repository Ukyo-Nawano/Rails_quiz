class QuizzesController < ApplicationController
    def index
        @quizzes = Quiz.includes(:choices).all
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
