class SessionsController < ApplicationController
    def new
        if current_user
            redirect_to users_path
        end
    end

    def create
        auth = request.env["omniauth.auth"]
    
        # Auth0からの情報をログ出力（デバッグ用）
        Rails.logger.info "Auth Info: #{auth.inspect}"
    
        # ユーザーを検索し、存在しない場合は新規作成
        user = User.find_or_initialize_by(uid: auth['uid'])
        user.email = auth['info']['email']
        user.name = auth['info']['name'] || "未設定" # 名前が空の場合のデフォルト値
        user.image = auth['info']['image'] # プロフィール画像（オプション）
    
        if user.new_record?
          user.save!
          Rails.logger.info "新規ユーザーをローカルに保存しました: #{user.inspect}"
        else
          Rails.logger.info "既存ユーザーがログインしました: #{user.inspect}"
        end
    
        # セッションにユーザーIDを保存
        session[:user_id] = user.id
        redirect_to users_path, notice: "ログインしました！"
      end
    

    def failure
    redirect_to login_path, alert: "Authentication failed"
    end

    def logout
        reset_session
        # Auth0のログアウトURLにリダイレクト
        redirect_to "https://#{ENV['AUTH0_DOMAIN']}/v2/logout?returnTo=#{root_url}&client_id=#{ENV['AUTH0_CLIENT_ID']}", allow_other_host: true
    end
end
