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
    session[:userinfo] = request.env['omniauth.auth']

    # Redirect to the URL you want after successful auth
    redirect_to '/quizzes'
  end

  def failure
    # Handles failed authentication -- Show a failure page (you can also handle with a redirect)
    @error_msg = request.params['message']
  end

  def logout
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
  
    domain = AUTH0_CONFIG['auth0_domain']
    Rails.logger.debug "Auth0 domain: #{domain}"
  
    raise ArgumentError, "Invalid domain" if domain.blank?
  
    URI::HTTPS.build(host: domain, path: '/v2/logout', query: request_params.to_query).to_s
  end
  
  
end