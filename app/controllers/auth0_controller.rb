# ./app/controllers/auth0_controller.rb
class Auth0Controller < ApplicationController
  def callback
    # OmniAuth stores the information returned from Auth0 and the IdP in request.env['omniauth.auth'].
    # In this code, you will pull the raw_info supplied from the id_token and assign it to the session.
    # Refer to https://github.com/auth0/omniauth-auth0/blob/master/EXAMPLES.md#example-of-the-resulting-authentication-hash for complete information on 'omniauth.auth' contents.
    auth_info = request.env['omniauth.auth']
    
    # Auth0から返される認証情報をログに出力
    Rails.logger.debug("Auth0 response: #{auth_info.inspect}")

    # ユーザー情報をセッションに保存
    # session[:userinfo] = auth_info['info']
    # session[:userinfo] = request.env['omniauth.auth']
    session[:userinfo] = {
      name: auth_info['info']['name'],      # 名前
      email: auth_info['info']['email'],
      nickname: auth_info['info']['nickname'], # メールアドレス
      image: auth_info['info']['image']     # プロフィール画像
    }

    # Redirect to the URL you want after successful auth
    redirect_to '/quizzes'
  end

  def failure
    # Handles failed authentication -- Show a failure page (you can also handle with a redirect)
    @error_msg = request.params['message']
  end

  def logout
    request.session_options[:skip] = true
    reset_session
    redirect_to logout_url, allow_other_host: true
  end

  private

  def logout_url
    Rails.logger.debug "AUTH0_CONFIG: #{AUTH0_CONFIG.inspect}"
    Rails.logger.debug "root_url: #{root_url}"
  
    request_params = {
      returnTo: root_url,
      client_id: AUTH0_CONFIG['auth0_client_id']
    }
  
    domain = AUTH0_CONFIG[:auth0_domain]
    
    # https:// を除去して、ドメイン名のみを抽出
    domain = domain.gsub(/\Ahttps?:\/\//, '') # https:// を除去

    # URIを構築
    logout_url = URI::HTTPS.build(host: domain, path: '/v2/logout', query: request_params.to_query).to_s
    Rails.logger.debug "Auth0 domain: #{domain}"
  
    raise ArgumentError, "Invalid domain" if domain.blank?
  
    URI::HTTPS.build(host: domain, path: '/v2/logout', query: request_params.to_query).to_s
  end
  
  
end