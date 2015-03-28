Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?    then
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  end

  provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_secret, scope: 'email'
  provider :google_oauth2, 'asdf', 'asdf'

  # provider :facebook, config["providers"]["facebook"]["key"], config["providers"]["facebook"]["secret"]
  # provider :google_oauth2, config["providers"]["google_oauth2"]["key"], config["providers"]["google_oauth2"]["secret"]
end
