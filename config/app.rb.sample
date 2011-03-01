class App < Configurable # :nodoc:
  # Settings in config/app/* take precedence over those specified here.
  config.name = Rails.application.class.parent.name
  config.devise_mailer_sender = "please-change-me@config-initializers-devise.com"
  config.uptime = Proc.new { (Time.now.utc - App.launched_at).seconds }
  config.action_mailer_default_host = "localhost:3000"
  config.google_analytics = "UA-xxxxxx-x"

  config.facebook_app_id = 1234
  config.facebook_app_secret = 5678
  # config.key = "value"
end

