Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook,      Rails.application.secrets.facebook_key, Rails.application.secrets.facebook_secret
  #provider :google_oauth2, Rails.application.secrets.google_key, Rails.application.secrets.google_secret
end