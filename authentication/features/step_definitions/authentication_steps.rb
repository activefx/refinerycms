def login_user
  visit new_user_session_path
  fill_in("user_login", :with => @user.email)
  fill_in("user_password", :with => 'password')
  click_button("user_submit")
end

def login_and_remember_user
  visit new_user_session_path
  fill_in("user_login", :with => @user.email)
  fill_in("user_password", :with => 'password')
  check("user_remember_me")
  click_button("user_submit")
end

def login_administrator
  visit new_administrator_session_path
  fill_in("administrator_login", :with => @administrator.email)
  fill_in("administrator_password", :with => 'password')
  click_button("submit_button")
end

def login_and_remember_administrator
  visit new_administrator_session_path
  fill_in("administrator_login", :with => @administrator.email)
  fill_in("administrator_password", :with => 'password')
  check("administrator_remember_me")
  click_button("submit_button")
end

Given /^No one is logged in$/ do
  visit('/users/sign_out')
  visit('/ctrlpnl/logout')
end

Given /^I am a visitor$/ do
  Given %{I am not logged in}
end

Then /^I should be signed out$/ do
  Given %{I am not logged in}
end

Given /^I am a logged in refinery administrator$/ do
  @administrator ||= Factory(:refinery_user)
  login_administrator
end

Given /^I have a logged in and remembered administrator named "(.*)"$/ do |name|
  @administrator ||= Factory(:refinery_user, :username => name)
  login_and_remember_administrator
end

Given /^I am a logged in user$/ do
  @user ||= Factory(:site_user)
  login_user
end

Given /^I am a logged in refinery user$/ do
  %{I am a logged in user}
end

Given /^I have a logged in and remembered user named "(.*)"$/ do |name|
  @user ||= Factory(:site_user, :username => name)
  login_and_remember_user
end

Given /^A Refinery administrator exists$/ do
  @administrator ||= Factory(:refinery_user)
end

Given /^A site user exists$/ do
  @user ||= Factory(:site_user)
end


Given /^I have a user named "(.*)"$/ do |name|
  Factory(:user, :username => name)
end

Given /^I have a site user named "(.*)"$/ do |name|
  Factory(:site_user, :username => name)
end

Given /^I have a locked site user named "(.*)"$/ do |name|
  Factory(:site_user, :username => name).lock_access!
end

Given /^I have a forgetful site user named "(.*)"$/ do |name|
  a = Factory(:site_user, :username => name)
  a.send(:generate_reset_password_token!)
  a.save
end

Given /^I have an administrator named "(.*)"$/ do |name|
  Factory(:administrator, :username => name)
end

Given /^I have a [R|r]efinery administrator named "(.*)"$/ do |name|
  Factory(:refinery_user, :username => name)
end

Given /^I have a locked refinery administrator named "(.*)"$/ do |name|
  Factory(:refinery_user, :username => name).lock_access!
end

Given /^I have a forgetful refinery administrator named "(.*)"$/ do |name|
  a = Factory(:refinery_user, :username => name)
  a.send(:generate_reset_password_token!)
  a.save
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
  if action.nil?
    @administrator.send(:generate_reset_password_token!)
    @administrator.save
  end
end

Given /^(User|Administrator) token authentication is enabled$/ do |model_name|
  model_name.constantize.class_eval do
    devise :token_authenticatable
  end
end

Given /^I login with (.+)$/ do |service|
  send("stub_#{service}!")
  visit "/users/auth/#{service}"
end

When /^I have a user "([^"]*)" with a "([^"]*)" token with a uid of "([^"]*)"$/ do |arg1, arg2, arg3|
  @user ||= Factory(:site_user, :username => arg1)
  @user.user_tokens.create(:provider => arg2, :uid => arg3)
end

When /^I am logged in with (.+)$/ do |service|
  steps %Q{
    When I have a user "some_user" with a "#{service}" token with a uid of "819797"
    When I login with #{service}
  }
end

Then /^"([^"]*)" should have been created by omniauth$/ do |arg1|
  User.where(:email => arg1).first.created_by_omniauth.should == true
end

Then /^"([^"]*)" should not have been created by omniauth$/ do |arg1|
  User.where(:email => arg1).first.created_by_omniauth.should == false
end

When /^I fail to login with facebook due to invalid credentials$/ do
  stub_facebook_invalid_credentials!
  visit "/users/auth/facebook"
end

When /^I fail to login with facebook due to access denied$/ do
  stub_facebook_access_denied!
  visit "/users/auth/facebook"
end

Then /^I should not be logged in$/ do
  steps %Q{
    Then I should not see "Sign Out"
    And I should not see "Signed in as"
  }
end

When /^I link my (.+) account/ do |service|
  send("stub_#{service}!")
  And %Q{I follow "Link Your #{service.titleize} Account"}
end

