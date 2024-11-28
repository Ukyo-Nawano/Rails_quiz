# ./config/initializers/auth0.rb
AUTH0_CONFIG = Rails.application.config_for(:auth0)

Rails.application.config.middleware.use OmniAuth::Builder do
provider(
    :auth0,
    AUTH0_CONFIG['auth0_client_id'],
    AUTH0_CONFIG['auth0_client_secret'],
    AUTH0_CONFIG['auth0_domain'], # ここが適切に渡されているか確認
    callback_path: '/auth/auth0/callback',
    authorize_params: {
    scope: 'openid profile email'
    }
)
end
