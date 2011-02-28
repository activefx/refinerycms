def login_user
  visit new_user_session_path
  fill_in("user_login", :with => @user.email)
  fill_in("user_password", :with => 'greenandjuicy')
  click_button("user_submit")
end

def login_administrator
  visit new_administrator_session_path
  fill_in("administrator_login", :with => @administrator.email)
  fill_in("administrator_password", :with => 'greenandjuicy')
  click_button("submit_button")
end

Given /^I am a logged in refinery administrator$/ do
  @administrator ||= Factory(:refinery_user)
  login_administrator
end

Given /^I am a logged in user$/ do
  @user ||= Factory(:site_user)
  login_user
end

Given /^A Refinery administrator exists$/ do
  @refinery_administrator ||= Factory(:refinery_user)
end

Given /^A site user exists$/ do
  @site_user ||= Factory(:site_user)
end


Given /^I have a user named "(.*)"$/ do |name|
  Factory(:user, :username => name)
end

Given /^I have a site user named "(.*)"$/ do |name|
  Factory(:site_user, :username => name)
end

Given /^I have an administrator named "(.*)"$/ do |name|
  Factory(:administrator, :username => name)
end

Given /^I have a R|refinery administrator named "(.*)"$/ do |name|
  Factory(:refinery_user, :username => name)
end

Given /^I have no users$/ do
  User.delete_all
end

Given /^I have no administrators$/ do
  Administrator.delete_all
end

Given /^I have no site interactors$/ do
  Actor.delete_all
end

Then /^I should have ([0-9]+) users?$/ do |count|
  User.count.should == count.to_i
end

Then /^I should have ([0-9]+) administrators?$/ do |count|
  Administrator.count.should == count.to_i
end

Given /^I have a user with email "(.*)"$/ do |email|
  Factory(:site_user, :email => email)
end

Given /^I am (not )?requesting password reset$/ do |action|
  @user = Factory(:site_user, :updated_at => 11.minutes.ago)
  @user.send(:generate_reset_password_token!) if action.nil?
end

Given /^I have an administrator with email "(.*)"$/ do |email|
  Factory(:refinery_user, :email => email)
end

Given /^I am (not )?requesting administrative password reset$/ do |action|
  @administrator = Factory(:refinery_user, :updated_at => 11.minutes.ago)
  @administrator.send(:generate_reset_password_token!) if action.nil?
end

