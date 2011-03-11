module Refinery
  module Helpers
    module AuthenticationHelper
      # A simple way to show error messages for the current devise resource. If you need
      # to customize this method, you can either overwrite it in your application helpers or
      # copy the views to your application.
      #
      # This method is intended to stay simple and it is unlikely that we are going to change
      # it to add more behavior or options.
      def custom_devise_error_messages!(sentance = nil)
        return "" if resource.errors.empty?

        messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
        sentence = if sentance.nil?
          I18n.t( "errors.messages.not_saved",
                  :count => resource.errors.count,
                  :resource => resource_name )
        else
          sentance
        end

        html = <<-HTML
        <div id="error_explanation">
          <h2>#{sentence}</h2>
          <ul>#{messages}</ul>
        </div>
        HTML

        html.html_safe
      end
    end
  end
end

