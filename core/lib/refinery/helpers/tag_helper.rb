module Refinery
  module Helpers
    module TagHelper

      # Returns <img class='help' tooltip='Your Input' src='refinery/icons/information.png' />
      # Remember to wrap your block with <span class='label_with_help'></span> if you're using a label next to the help tag.
      def refinery_help_tag(title='')
        title = h(title) unless title.html_safe?

        refinery_icon_tag('information', :class => 'help', :tooltip => title)
      end

      # This is just a quick wrapper to render an image tag that lives inside refinery/icons.
      # They are all 16x16 so this is the default but is able to be overriden with supplied options.
      def refinery_icon_tag(filename, options = {})
        filename = "#{filename}.png" unless filename.split('.').many?
        image_tag "refinery/icons/#{filename}", {:width => 16, :height => 16}.merge(options)
      end

      def confirmable_help_tag(actor_class)
        refinery_help_tag t('devise.confirmable.confirmable_help',
          :time_limit => actor_class.confirmation_time_limit_helper)
      end

      def database_authenticatable_help_tag(actor_class)
        refinery_help_tag t('devise.database_authenticatable.database_authenticatable_help',
          :encryptor => actor_class.encryptor_name_helper)
      end

      def encryptable_help_tag(actor_class=nil)
        refinery_help_tag t('devise.encryptable.encryptable_help')
      end

      def lockable_help_tag(actor_class)
        refinery_help_tag t('devise.lockable.lockable_help',
          :failed_attempts => actor_class.failed_attempts_helper,
          :unlock_strategies => actor_class.unlock_strategy_helper)
      end

      def omniauthable_help_tag(actor_class)
        refinery_help_tag t('devise.omniauthable.omniauthable_help',
          :providers => actor_class.providers_helper)
      end

      def recoverable_help_tag(actor_class=nil)
        refinery_help_tag t('devise.recoverable.recoverable_help')
      end

      def registerable_help_tag(actor_class=nil)
        refinery_help_tag t('devise.registerable.registerable_help')
      end

      def rememberable_help_tag(actor_class=nil)
        refinery_help_tag t('devise.rememberable.rememberable_help')
      end

      def timeoutable_help_tag(actor_class=nil)
        refinery_help_tag t('devise.timeoutable.timeoutable_help',
          :timeout => actor_class.timeout_helper)
      end

      def token_authenticatable_help_tag(actor_class=nil)
        refinery_help_tag t('devise.token_authenticatable.token_authenticatable_help')
      end

      def trackable_help_tag(actor_class=nil)
        refinery_help_tag t('devise.trackable.trackable_help')
      end

      def validatable_help_tag(actor_class)
        refinery_help_tag t('devise.validatable.validatable_help',
          :password_length => actor_class.password_length)
      end

    end
  end
end

