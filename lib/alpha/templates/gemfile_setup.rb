run 'rm Gemfile'
create_file 'Gemfile', "source 'http://rubygems.org'\n"
gem "rails", "3.0.5"

# Database
gem 'mongoid', :git => 'git://github.com/mongoid/mongoid.git'
gem 'bson_ext', '>= 1.2.1'
gem 'mongoid_slug', :require => 'mongoid/slug'
gem 'mongoid_nested_set', :git => 'git://github.com/activefx/mongoid_nested_set.git'
gem 'mongoid_search', :git => 'git://github.com/activefx/mongoid_search_relevant.git'

run 'bundle install'

