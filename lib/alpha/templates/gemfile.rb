
# Authentication & Authorization
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'
gem 'oa-oauth', :require => 'omniauth/oauth'
gem "oa-openid", :require => "omniauth/openid"

# RefineryCMS
gem 'refinerycms', :path => '../refinerycms'
gem 'refinerycms-authentication', :path => '../refinerycms/authentication'
gem 'refinerycms-base', :path => '../refinerycms/base'
gem 'refinerycms-core', :path => '../refinerycms/core'
gem 'refinerycms-dashboard', :path => '../refinerycms/dashboard'
gem 'refinerycms-images', :path => '../refinerycms/images'
gem 'refinerycms-pages', :path => '../refinerycms/pages'
gem 'refinerycms-resources', :path => '../refinerycms/resources'
gem 'refinerycms-settings', :path => '../refinerycms/settings'
gem 'refinerycms-generators', :path => '../refinerycms-generators'

# Background Processing
gem 'delayed_job'
gem 'delayed_job_mongoid'

# Monitoring
gem "hoptoad_notifier"

# Assets
#gem "jammit"

# Views
gem "haml", "~> 3.0.21"
gem "haml-rails"
gem "will_paginate", "~> 3.0.pre2"
gem 'show_for'
gem 'simple_form'

# Documentation
gem "yard"

# Configuration
gem "app"

# Deployment
gem 'capistrano'

# Other
gem "hpricot"

# Development Only
gem "rails3-generators", :group => :development
gem "ruby_parser", :group => :development

# Test Only
gem "mocha", :group => :test

# Development and Testing
gem 'refinerycms-testing', :path => '../refinerycms/testing', :group => [:development, :test]
gem "rspec-rails", ">= 2.5.0", :group => [:development, :test]
gem 'mynyml-redgreen', :require => 'redgreen', :group => [:development, :test]
gem 'mongoid-rspec', :git => 'git://github.com/durran/mongoid-rspec.git', :group => [:development, :test]
gem "evergreen", :require => "evergreen/rails", :group => [:development, :test]
# To use debugger
# gem 'ruby-debug'
# or in 1.9.x:
gem 'ruby-debug19', :require => 'ruby-debug', :group => [:development, :test]

# Cucumber Only
gem "cucumber", :group => :cucumber
gem "cucumber-rails", :group => :cucumber
gem "launchy", :group => :cucumber

# Test and Cucumber
gem "factory_girl_rails", :group => [:test, :cucumber]
gem "faker", :group => [:test, :cucumber]
gem "autotest", :group => [:test, :cucumber]
gem "autotest-rails", :group => [:test, :cucumber]
gem "database_cleaner", :group => [:test, :cucumber]
gem "capybara", ">= 0.4.1", :group => [:test, :cucumber]
gem "timecop", :group => [:test, :cucumber]
gem "pickle", :group => [:test, :cucumber]

# Test, Cucumber, and Development
gem "thin", :group => [:test, :cucumber, :development]

# for windows users
if ( (Config::CONFIG['host_os'] =~ /mswin|mingw/) && (Config::CONFIG["ruby_version"] =~ /1.8/) )
  gem "win32console", :group => [:test, :cucumber]
  gem "windows-pr", :group => [:test, :cucumber]
  gem "win32-open3"
end

run 'bundle install'

