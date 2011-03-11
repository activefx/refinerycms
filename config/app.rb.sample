class App < Configurable # :nodoc:
  # Settings in config/app/* take precedence over those specified here.
  config.name = Rails.application.class.parent.name
  config.devise_mailer_sender = "please-change-me@config-initializers-devise.com"
  config.uptime = Proc.new { (Time.now.utc - App.launched_at).seconds }
  config.action_mailer_default_host = "localhost:3000"
  config.google_analytics = "UA-xxxxxx-x"

  config.facebook_app_id = "xxxx"
  config.facebook_app_secret = "xxxx"
  config.facebook_api_key = "xxxx"

  config.twitter_app_id = "xxxx"
  config.twitter_app_secret = "xxxx"
  config.twitter_api_key = "xxxx"
  # config.key = "value"
end

