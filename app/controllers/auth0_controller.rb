class Auth0Controller < ApplicationController
    def login
        @user = session[:userinfo]
    end

    def callback
    # Auth0からのユーザー情報をセッションに保存
    session[:userinfo] = request.env['omniauth.auth']
    redirect_to root_path
    end

    def failure
    @error_msg = request.params['message']
    end

    def logout
    reset_session
    redirect_to "https://#{ENV['AUTH0_DOMAIN']}/v2/logout?client_id=#{ENV['AUTH0_CLIENT_ID']}&returnTo=#{root_url}"
    end
end
