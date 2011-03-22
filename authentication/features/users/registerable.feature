# https://github.com/fortuity/rails3-mongoid-devise/blob/master/features/step_definitions/user_steps.rb

#@refinerycms @authentication @users @registerable
#Feature: Registerable (Sign Up & Edit Account)
#  In order to get access to protected sections of the site
#  As a user
#  I want to be able to sign up and edit my account

#  Background:
#    Given I have no users
#    And A Refinery administrator exists
#    And I have a page titled "Home" with a custom url "/"

#    Scenario: User signs up with valid data
#      Given I am not logged in
#      When I go to the sign up page
#      And I fill in "user_username" with "user"
#      And I fill in "user_email" with "user@example.com"
#      And I fill in "user_password" with "password"
#      And I fill in "user_password_confirmation" with "password"
#      And I press "Sign up"
#      Then I should see signed up successfully message

#    Scenario: User signs up with invalid email
#      Given I am not logged in
#      When I go to the sign up page
#      And I fill in "Email" with "invalidemail"
#      And I fill in "Password" with "please"
#      And I fill in "Password confirmation" with "please"
#      And I press "Sign up"
#      Then I should see "Email is invalid"

#    Scenario: User signs up without password
#      Given I am not logged in
#      When I go to the sign up page
#      And I fill in "Email" with "user@test.com"
#      And I fill in "Password" with ""
#      And I fill in "Password confirmation" with "please"
#      And I press "Sign up"
#      Then I should see "Password can't be blank"

#    Scenario: User signs up without password confirmation
#      Given I am not logged in
#      When I go to the sign up page
#      And I fill in "Email" with "user@test.com"
#      And I fill in "Password" with "please"
#      And I fill in "Password confirmation" with ""
#      And I press "Sign up"
#      Then I should see "Password doesn't match confirmation"

#    Scenario: User signs up with password and password confirmation that doesn't match
#      Given I am not logged in
#      When I go to the sign up page
#      And I fill in "Email" with "user@test.com"
#      And I fill in "Password" with "please"
#      And I fill in "Password confirmation" with "please1"
#      And I press "Sign up"
#      Then I should see "Password doesn't match confirmation"


#Feature: Create an account and log in
#  In order to log in
#  As a user
#  I want to create an account and log in

#  Scenario: Create an Account
#    Given I am not authenticated
#    And I am on Sign up
#    And I fill in "email" with "joe_unconfirmed@example.com"
#    And I fill in "password" with "password"
#    And I fill in "password confirmation" with "password"
#    And I press "user_submit"
#    Then I should be on User index
#    And I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."

#  Scenario: Signed-in User is Logged-in
#    Given I am not authenticated
#    And I am a new, confirmed user with email joe3@example.com and password password
#    And I am on Sign in
#    And I fill in "email" with "joe3@example.com"
#    And I fill in "password" with "password"
#    And I press "user_submit"
#    Then I should be on User index

#  Feature: Edit User
#  As a registered user of the website
#  I want to edit my user profile
#  so I can change my username

#    Scenario: I sign in and edit my account
#      Given I am a user named "foo" with an email "user@test.com" and password "please"
#      When I sign in as "user@test.com/please"
#      Then I should be signed in
#      When I follow "Edit account"
#      And I fill in "Name" with "baz"
#      And I fill in "Current password" with "please"
#      And I press "Update"
#      And I go to the homepage
#      Then I should see "User: baz"

