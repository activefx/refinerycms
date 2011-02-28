require 'devise'
require 'refinerycms-core'
# Attach authenticated system methods to the ::Refinery::ApplicationController
require File.expand_path('../authenticated_system', __FILE__)
[::Refinery::ApplicationController, ::Refinery::ApplicationHelper].each do |c|
  c.class_eval {
    include AuthenticatedSystem
  }
end

module Refinery
  module Authentication

    class Engine < ::Rails::Engine
      config.autoload_paths += %W( #{config.root}/lib )

      config.after_initialize do
        # Register the user's plugin
        ::Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_users"
          plugin.version = %q{0.9.9}
          plugin.menu_match = /(refinery|admin)\/users$/
          plugin.activity = {
            :class => User,
            :title => 'login'
          }
          plugin.url = {:controller => "/admin/users"}
        end

        # Register the administrator's plugin
        ::Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_administrators"
          plugin.version = %q{0.9.9}
          plugin.menu_match = /(refinery|admin)\/administrators$/
          plugin.activity = {
            :class => Administrator,
            :title => 'login'
          }
          plugin.url = {:controller => "/admin/administrators"}
        end
      end
    end

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end
  end

  class << self
    attr_accessor :authentication_login_field
    def authentication_login_field
      @authentication_login_field ||= 'login'
    end
  end
end

::Refinery.engines << 'authentication'

