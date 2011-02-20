require 'factory_girl'

Factory.define :site_user do |u|
  u.sequence(:username) { |n| "person#{n}" }
  u.sequence(:email) { |n| "person#{n}@cucumber.com" }
  u.password  "greenandjuicy"
  u.password_confirmation "greenandjuicy"
end

Factory.define :main_site_user, :parent => :site_user do |u|
  u.after_create { |user| user.confirm! if SiteUser.confirmable? }
  u.after_create { |user| user.add_role(:refinery) }
  u.after_create do |user|
    Refinery::Plugins.registered.each_with_index do |plugin, index|
      user.plugins.create(:name => plugin.name, :position => index)
    end
  end
end

Factory.define :user do |u|
  u.sequence(:username) { |n| "admin#{n}" }
  u.sequence(:email) { |n| "admin#{n}@cucumber.com" }
  u.password  "greenandjuicy"
  u.password_confirmation "greenandjuicy"
end

Factory.define :refinery_user, :parent => :user do |u|
  u.after_create { |user| user.confirm! if User.confirmable? }
  u.after_create { |user| user.add_role(:refinery) }
  u.after_create do |user|
    Refinery::Plugins.registered.each_with_index do |plugin, index|
      user.plugins.create(:name => plugin.name, :position => index)
    end
  end
end

