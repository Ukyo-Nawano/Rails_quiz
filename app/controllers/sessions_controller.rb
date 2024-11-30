class SessionsController < ApplicationController
    def new
      # ログインページを表示
    end
  
    def create
      auth_hash = request.env['omniauth.auth']
      user_info = auth_hash['extra']['raw_info']
  
      # ユーザー情報をセッションに保存
      session[:user] = {
        uid: auth_hash['uid'],
        name: user_info['name'],
        email: user_info['email'],
        image: user_info['picture']
      }
  
      redirect_to quizzes_path, notice: 'ログインに成功しました'
    end
  
    def destroy
      session[:user] = nil
      redirect_to root_path, notice: 'ログアウトしました'
    end
  end
  