require 'refinerycms-core'
require 'mongoid'
require 'mongoid_search'
require 'mongoid/slug'
require 'mongoid_nested_set'
require 'seo_meta'

module Refinery
  module Pages

    autoload :InstanceMethods, File.expand_path('../refinery/pages/instance_methods', __FILE__)
    module Admin
      autoload :InstanceMethods, File.expand_path('../refinery/pages/admin/instance_methods', __FILE__)
    end

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < ::Rails::Engine
      initializer 'serve static assets' do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.to_prepare do
        require File.expand_path('../pages/tabs', __FILE__)
      end

      refinery.after_inclusion do
        ::ApplicationController.send :include, ::Refinery::Pages::InstanceMethods
        ::Admin::BaseController.send :include, ::Refinery::Pages::Admin::InstanceMethods
      end

      config.after_initialize do
        ::Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'refinery_pages'
          plugin.directory = 'pages'
          plugin.version = %q{1.0.0}
          plugin.menu_match = /(refinery|admin)\/page(_part)?s(_dialogs)?$/
          plugin.activity = {
            :class => Page,
            :url_prefix => 'edit',
            :title => 'title',
            :created_image => 'page_add.png',
            :updated_image => 'page_edit.png'
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

