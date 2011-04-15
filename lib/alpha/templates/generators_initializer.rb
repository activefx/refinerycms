

create_file 'config/initializers/generators.rb' do
<<-FILE
#{@app_name.camelcase}::Application.config.generators do |g|
  #g.scaffold :scaffold_controller => :responders_controller
  g.orm :mongoid
  g.template_engine :haml
  g.integration_tool :rspec
  g.test_framework :rspec, :fixture => true, :views => false
  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
  g.stylesheets false
  g.helper false
end
FILE
end

