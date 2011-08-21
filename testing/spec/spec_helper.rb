#Copies to new apps

require 'rbconfig'
require 'factory_girl'
require File.expand_path('../support/refinery/controller_macros', __FILE__)

def setup_environment
  # This file is copied to ~/spec when you run 'rails generate rspec'
  # from the project root directory.

  # https://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu
  require "rails/mongoid"
  Spork.trap_class_method(Rails::Mongoid, :load_models)

  require "rails/application"
  Spork.trap_method(Rails::Application, :reload_routes!)

  require 'factory_girl_rails'
  Spork.trap_class_method(Factory, :find_definitions)

  ENV["RAILS_ENV"] ||= 'test'
  ENV["CACHE_CLASS_FLAG"] = 'false'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'vcr'
  require 'database_cleaner'

  VCR.config do |c|
    c.ignore_localhost = true
    c.cassette_library_dir = 'spec/cassettes'
    c.stub_with :webmock #:typhoeus, :fakeweb, or :webmock
    c.default_cassette_options = { :record => :new_episodes }
  end

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    # config.mock_with :rspec
    config.mock_with :mocha
    config.include Devise::TestHelpers, :type => :controller
    config.include Mongoid::Matchers
    config.extend VCR::RSpec::Macros

    # config.fixture_path = ::Rails.root.join('spec', 'fixtures').to_s

    DatabaseCleaner.orm = "mongoid"
    DatabaseCleaner.strategy = :truncation

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:all) do
      DatabaseCleaner[:mongoid].clean
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, comment the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    ActiveSupport::Dependencies.clear
    config.include Mongoid::Matchers
    config.include ::Devise::TestHelpers, :type => :controller
    config.extend ::Refinery::ControllerMacros, :type => :controller

  end
end

def each_run
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
end

require 'rubygems'
# If spork is available in the Gemfile it'll be used but we don't force it.
unless RbConfig::CONFIG["host_os"] =~ %r!(msdos|mswin|djgpp|mingw)! or (begin; require 'spork'; rescue LoadError; nil end).nil?
  require 'spork'
  #require File.expand_path("../spork-ruby-debug", __FILE__)

  Spork.prefork do
    # Loading more in this block will cause your tests to run faster. However,
    # if you change any configuration or code from libraries loaded here, you'll
    # need to restart spork for it take effect.
    setup_environment

  end

  Spork.each_run do
    # This code will be run each time you run your specs.
    each_run

  end

  # --- Instructions ---
  # - Sort through your spec_helper file. Place as much environment loading
  #   code that you don't normally modify during development in the
  #   Spork.prefork block.
  # - Place the rest under Spork.each_run block
  # - Any code that is left outside of the blocks will be ran during preforking
  #   and during each_run!
  # - These instructions should self-destruct in 10 seconds.  If they don't,
  #   feel free to delete them.
  #
else
  setup_environment
  each_run
end

def capture_stdout(stdin_str = '')
  begin
    require 'stringio'
    $o_stdin, $o_stdout, $o_stderr = $stdin, $stdout, $stderr
    $stdin, $stdout, $stderr = StringIO.new(stdin_str), StringIO.new, StringIO.new
    yield
    {:stdout => $stdout.string, :stderr => $stderr.string}
  ensure
    $stdin, $stdout, $stderr = $o_stdin, $o_stdout, $o_stderr
  end
end

