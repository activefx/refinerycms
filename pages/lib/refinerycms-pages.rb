require 'refinerycms-core'
require 'mongoid'
require 'mongoid_nested_set'
#require 'globalize3'

module Refinery
  module Pages

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < ::Rails::Engine

      config.to_prepare do
        require File.expand_path('../pages/tabs', __FILE__)
      end

      config.after_initialize do
        ::Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_pages"
          plugin.directory = "pages"
          plugin.version = %q{0.9.9}
          plugin.menu_match = /(refinery|admin)\/page(_part)?s(_dialogs)?$/
          plugin.activity = {
            :class => Page,
            :url_prefix => "edit",
            :title => "title",
            :created_image => "page_add.png",
            :updated_image => "page_edit.png"
          }
        end
      end

      initializer 'add marketable routes' do |app|
        app.routes_reloader.paths << File.expand_path('../pages/marketable_routes.rb', __FILE__)
      end

      initializer 'add nested set options' do |app|
        if defined?(ActionView)
          require File.expand_path('../pages/nested_set_options', __FILE__)
          ActionView::Base.class_eval do
            include NestedSetOptions
          end
        end
      end

    end
  end
end

::Refinery.engines << 'pages'

