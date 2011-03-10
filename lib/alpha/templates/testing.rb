empty_directory "spec/controllers"
empty_directory "spec/models"
empty_directory "spec/views"
empty_directory "spec/helpers"
empty_directory "features/step_definitions"
empty_directory "features/support"

inject_into_file 'config/application.rb', :after => "# Configure the default encoding used in templates for Ruby 1.9.\n" do
<<-RUBY
    config.generators do |g|
      g.test_framework :rspec
    end
RUBY
end

