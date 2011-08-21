require 'factory_girl'

begin
  Factory.define :user do |u|
    u.sequence(:username) { |n| "person#{n}" }
    u.sequence(:email) { |n| "person#{n}@cucumber.com" }
    u.password  "greenandjuicy"
    u.password_confirmation "greenandjuicy"
  end
rescue FactoryGirl::DuplicateDefinitionError; end

begin
  Factory.define :refinery_user, :parent => :user do |u|
    u.after_create { |user| user.add_role(:refinery) }

    u.after_create do |user|
      Refinery::Plugins.registered.each_with_index do |plugin, index|
        user.plugins.create(:name => plugin.name, :position => index)
      end
    end
  end
rescue FactoryGirl::DuplicateDefinitionError; end

begin
  Factory.define :refinery_translator, :parent => :user do |u|
    u.roles { [ Role[:refinery], Role[:translator] ] }

    u.after_create do |user|
      user.plugins.create(:name => 'refinery_pages', :position => 0)
    end
  end
rescue FactoryGirl::DuplicateDefinitionError; end

