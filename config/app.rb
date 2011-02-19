class App < Configurable # :nodoc:
  # Settings in config/app/* take precedence over those specified here.
  config.name = Rails.application.class.parent.name
  config.devise_mailer_sender = "please-change-me@config-initializers-devise.com"
  config.uptime = Proc.new { (Time.now.utc - App.launched_at).seconds }
  # config.key = "value"
end

