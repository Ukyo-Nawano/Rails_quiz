class FavoritesController < ApplicationController
    def create
        @quiz = Quiz.find(params[:quiz_id])
        @favorite = current_user.favorites.find_by(quiz_id: @quiz.id)
    
        if @favorite
          # 既にお気に入りが存在する場合は、削除する
          @favorite.destroy
          render json: { favorited: false }
        else
          # お気に入りが存在しない場合は、新規に作成
          @favorite = current_user.favorites.create(quiz_id: @quiz.id)
          render json: { favorited: true }
        end
    end

    def destroy
        favorite = current_user.favorites.find_by(quiz_id: params[:quiz_id])

        if favorite&.destroy
            render json: { favorited: false }
        else
            render json: { error: "お気に入り解除に失敗しました。" }, status: :unprocessable_entity
        end
    end
end
