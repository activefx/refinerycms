module Refinery
  module Helpers
    module TitleHelper

      def content_title(title)
        content = ""
        content << content_tag(:div, :id => 'flash_container') do
            partials = ""
            partials << render(:partial => '/shared/no_script')
            partials << render(:partial => "/shared/message")
            partials.html_safe
        end
        content << content_tag(:h1, title)

        content_for :body_content_title do
          content.html_safe
        end
      end


    end
  end
end

