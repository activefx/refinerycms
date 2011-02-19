source 'http://rubygems.org'

gemspec

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails'

#if RUBY_PLATFORM == 'java'
#  gem 'activerecord-jdbcsqlite3-adapter', '>= 1.0.2', :platform => :jruby
#else
#  gem 'sqlite3'
#end

gem 'mongoid', :git => 'git://github.com/mongoid/mongoid.git'
gem 'bson_ext', '>= 1.2.1'
gem 'mongoid_slug', :require => 'mongoid/slug'
gem 'mongoid_nested_set', :git => 'git://github.com/activefx/mongoid_nested_set.git'
gem 'mongoid_search', :git => 'git://github.com/activefx/mongoid_search_relevant.git'
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'

# Use unicorn as the web server
# gem 'unicorn'
# gem 'mongrel'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'
# or in 1.9.x:
gem 'ruby-debug19', :require => 'ruby-debug'

# For Heroku/s3:
# gem 'aws-s3', :require => 'aws/s3'

# REFINERY CMS ================================================================
# Anything you put in here will be overridden when the app gets updated.

#gem 'refinerycms', :path => '.'
gem 'refinerycms-authentication', :path => 'authentication'
gem 'refinerycms-base', :path => 'base'
gem 'refinerycms-core', :path => 'core'
gem 'refinerycms-dashboard', :path => 'dashboard'
gem 'refinerycms-images', :path => 'images'
gem 'refinerycms-pages', :path => 'pages'
gem 'refinerycms-resources', :path => 'resources'
gem 'refinerycms-settings', :path => 'settings'
gem 'refinerycms-generators', :path => '../refinerycms-generators'

group :development, :test do
  gem 'refinerycms-testing', :path => 'testing'
  gem 'mongoid-rspec', :git => 'git://github.com/durran/mongoid-rspec.git'
end

# END REFINERY CMS ============================================================

# REFINERY CMS DEVELOPMENT ====================================================

# END REFINERY CMS DEVELOPMENT =================================================

# USER DEFINED

# Specify additional Refinery CMS Engines here (all optional):
# gem 'refinerycms-inquiries',    '~> 0.9'
# gem 'refinerycms-news',         '~> 1.0'
# gem 'refinerycms-portfolio',    '~> 0.9.9'
# gem 'refinerycms-theming',      '~> 0.9.9'
# gem 'refinerycms-search',       '~> 0.9.8'
# gem 'refinerycms-blog',         '~> 1.1'
# gem 'refinerycms-page-images,   '~> 1.0

# Add i18n support (optional, you can remove this if you really want to).
# gem 'refinerycms-i18n',         '~> 0.9.9.9'

# END USER DEFINED

