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

