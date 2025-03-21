class FavoritesController < ApplicationController
    def create
        @quiz = Quiz.find(params[:quiz_id])
        @user = current_user
    
        favorite = @user.favorites.find_by(quiz: @quiz)
    
        if favorite
          favorite.destroy
          favorited = false
        else
          @user.favorites.create(quiz: @quiz)
          favorited = true
        end
        render json: { favorited: favorited, favorite_count: @quiz.favorites.count }, status: :ok
      end

      def destroy
        # 送信された quiz_id を使用して、お気に入りを取得
        favorite = current_user.favorites.find_by(quiz_id: params[:quiz_id])
        quiz = Quiz.find(params[:quiz_id]) # クイズを取得
    
        if favorite&.destroy
          render json: { favorited: false, favorite_count: quiz.favorites.count }, status: :ok
        else
          render json: { error: "お気に入り解除に失敗しました。" }, status: :unprocessable_entity
        end
      end

    def toggle
      quiz = Quiz.find(params[:quiz_id])
      favorite = current_user.favorites.find_by(quiz: quiz)
  
      if favorite
        favorite.destroy
        favorited = false
      else
        current_user.favorites.create(quiz: quiz)
        favorited = true
      end
  
      render json: { favorited: favorited, favorite_count: quiz.favorites.count }
    end
end
