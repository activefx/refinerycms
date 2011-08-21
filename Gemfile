source 'http://rubygems.org'

gemspec

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails'

# Use unicorn as the web server
# gem 'unicorn'
# gem 'mongrel'

# Deploy with Capistrano
# gem 'capistrano'

# For Heroku/s3:
# gem 'fog'

# REFINERY CMS ================================================================
# Anything you put in here will be overridden when the app gets updated.


gem 'mongoid', '>= 2.1.8', :git => 'git://github.com/mongoid/mongoid.git'
gem 'bson_ext', '>= 1.3'
gem 'mongoid_slug', :require => 'mongoid/slug'
gem 'mongoid_nested_set', :git => 'git://github.com/activefx/mongoid_nested_set.git'
gem 'mongoid_search', :git => 'git://github.com/mauriciozaffari/mongoid_search.git'
gem 'devise', '~> 1.3.0'
gem 'omniauth', :git => 'git://github.com/intridea/omniauth.git'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem "oa-openid", :require => "omniauth/openid"

# gem 'refinerycms', :path => '../refinerycms'
gem 'refinerycms-authentication', '~> 1.0.4', :path => 'authentication'
gem 'refinerycms-base', '~> 1.0.4', :path => 'base'
gem 'refinerycms-core', '~> 1.0.4', :path => 'core'
gem 'refinerycms-dashboard', '~> 1.0.4', :path => 'dashboard'
gem 'refinerycms-images', '~> 1.0.4', :path => 'images'
gem 'refinerycms-pages', '~> 1.0.4', :path => 'pages'
gem 'refinerycms-resources', '~> 1.0.4', :path => 'resources'
gem 'refinerycms-settings', '~> 1.0.4', :path => 'settings'

#################
#gem 'refinerycms-generators', '~> 1.0.4', :path => '../refinerycms-generators'
#################

group :development do
  gem "bundler", ">= 1.0.0"
  gem "jeweler", ">= 1.5.2"
  gem "rcov", ">= 0"
end

group :development, :test do
  gem 'refinerycms-testing', '~> 1.0.4', :path => 'testing'
  gem 'mynyml-redgreen', :require => 'redgreen'
  gem 'mongoid-rspec', :git => 'git://github.com/evansagge/mongoid-rspec.git'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  # To use debugger
  # gem 'ruby-debug'
  # or in 1.9.x:
  gem 'ruby-debug19', :require => 'ruby-debug'
end

# END REFINERY CMS ============================================================

# REFINERY CMS DEVELOPMENT ====================================================

if RUBY_PLATFORM == 'java'
  gem 'activerecord-jdbcsqlite3-adapter', '>= 1.0.2', :platform => :jruby
else
  gem 'sqlite3'
  gem 'mysql2', '~> 0.2.7'
end

gem 'rcov', :platform => :mri_18
gem 'simplecov', :platform => :mri_19

# END REFINERY CMS DEVELOPMENT ================================================

# USER DEFINED
# gem 'refinerycms-blog', :path => '../refinerycms-blog'
# Specify additional Refinery CMS Engines here (all optional):
# gem 'refinerycms-inquiries',    '~> 1.0'
# gem "refinerycms-news",         '~> 1.2'
# gem 'refinerycms-blog',         '~> 1.6'
# gem 'refinerycms-page-images',  '~> 1.0'

# Add i18n support (optional, you can remove this if you really want to).
# gem 'refinerycms-i18n',         '~> 1.0.0'

# END USER DEFINED

