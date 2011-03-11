@refinerycms @authentication @users @user
Feature: User
  In order interact with restricted site content and features
  As a user
  I want to have access to authentication features

  Background:
    Given I have no users
    And A Refinery administrator exists
    And I have a page titled "Home" with a custom url "/"

  Scenario: Home Page
    When I go to the home page
    And I am a visitor
    Then I should see "Sign In"
    And I should see "Register"

  Scenario: Login (successful login)
    Given I am on the login page
    And I have a site user named "user"
    And I fill in "user_login" with "user"
    And I fill in "user_password" with "greenandjuicy"
    And I press "Sign in"
    Then I should see "Signed in as user"
    And I should be on the user root

  Scenario: Login (unsuccessful login)
    Given I am on the login page
    And I have a site user named "user"
    And I fill in "user_login" with "jdfhaljfhdsjkf"
    And I fill in "user_password" with "aksdfjlkdsjflk"
    And I press "Sign in"
    Then I should see "Sorry, your login or password was incorrect."

  Scenario: Logout
    Given I am a logged in user
    And I am on the home page
    And I follow "Sign Out"
    Then I should be on the home page
    And I should not see "Sign Out"

  @users-password-forgot
  Scenario: Forgot Password page (no email entered)
    And I am on the forgot password page
    When I press "Send Instructions"
    Then I should see "There was a problem sending your password reset instructions"
    And I should see "Email can't be blank"

  @users-password-forgot
  Scenario: Forgot Password page (non existing email entered)
    Given I am on the forgot password page
    And I have a user with email "green@cukes.com"
    When I fill in "user_email" with "none@cukes.com"
    And I press "Send Instructions"
    Then I should see "There was a problem sending your password reset instructions"
    And I should see "Email not found"

  @users-password-forgot
  Scenario: Forgot Password page (existing email entered)
    Given I am on the forgot password page
    And I have a user with email "green@cukes.com"
    When I fill in "user_email" with "green@cukes.com"
    And I press "Send Instructions"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes"

#  @users-password-reset
#  Scenario: Reset password page (invalid reset_code)
#    Given I am not requesting password reset
#    When I go to the reset password page
#    Then I should be on the forgot password page
#    And I should see "We're sorry, but this reset code has expired or is invalid."
#    And I should see "If you are having issues try copying and pasting the URL from your email into your browser or restarting the reset password process."

#  @users-password-reset
#  Scenario: Reset password page (invalid password)
#    Given I am requesting password reset
#    When I go to the reset password page
#    And I fill in "Password" with "cukes"
#    And I fill in "Password confirmation" with "cukes"
#    And I press "Reset password"
#    Then I should see "There were problems with the following fields"
#    And I should see "Password is too short"

#  @users-password-reset
#  Scenario: Reset password page (valid reset_code)
#    Given I am requesting password reset
#    When I go to the reset password page
#    And I fill in "Password" with "icuked"
#    And I fill in "Password confirmation" with "icuked"
#    And I press "Reset password"
#    Then I should be on the user root
#    And I should see "Password reset successfully for"


#  @administrators-password-forgot
#  Scenario: Forgot Password page (no email entered)
#    And I am on the administrative forgot password page
#    When I press "Reset password"
#    Then I should see "You did not enter an email address."

#  @administrators-password-forgot
#  Scenario: Forgot Password page (non existing email entered)
#    Given I am on the administrative forgot password page
#    And I have an administrator with email "green@cukes.com"
#    When I fill in "administrator_email" with "none@cukes.com"
#    And I press "Reset password"
#    Then I should see "Sorry, 'none@cukes.com' isn't associated with any accounts."
#    And I should see "Are you sure you typed the correct email address?"

#  @administrators-password-forgot
#  Scenario: Forgot Password page (existing email entered)
#    Given I am on the administrative forgot password page
#    And I have an administrator with email "green@cukes.com"
#    When I fill in "administrator_email" with "green@cukes.com"
#    And I press "Reset password"
#    Then I should see "An email has been sent to you with a link to reset your password."

#  @administrators-password-reset
#  Scenario: Reset password page (invalid reset_code)
#    Given I am not requesting administrative password reset
#    When I go to the administrative reset password page
#    Then I should be on the administrative forgot password page
#    And I should see "We're sorry, but this reset code has expired or is invalid."
#    And I should see "If you are having issues try copying and pasting the URL from your email into your browser or restarting the reset password process."

#  @administrators-password-reset
#  Scenario: Reset password page (invalid password)
#    Given I am requesting administrative password reset
#    When I go to the administrative reset password page
#    And I fill in "Password" with "cukes"
#    And I fill in "Password confirmation" with "cukes"
#    And I press "Reset password"
#    Then I should see "There were problems with the following fields"
#    And I should see "Password is too short"

#  @administrators-password-reset
#  Scenario: Reset password page (valid reset_code)
#    Given I am requesting administrative password reset
#    When I go to the administrative reset password page
#    And I fill in "Password" with "icuked"
#    And I fill in "Password confirmation" with "icuked"
#    And I press "Reset password"
#    Then I should be on the admin root
#    And I should see "Password reset successfully for"

#Feature: Registration
#  In order to use My Great Application
#  As a user
#  I want to be able to register
#
#  Scenario: 'Standard Registration'
#    Given I am not currently logged in
#    When I am on the signup page
#    Then I should see "Sign Up"
#    And I fill in "Name (required)" with "Mickey Dolenz"
#    And I fill in "Email (required)" with "mickey@monkees.com"
#    And I fill in "Password (required)" with "password"
#    And I fill in "Password confirmation" with "password"
#    And I press "Register"
#    Then I should see "Sign Up - Confirm Your Account"
#    Then I should be on the registration thank you page
#    Then "mickey@monkees.com" should receive an email
#    When I open the email
#    Then I should see "Confirm my account" in the email body
#    When I follow "Confirm my account" in the email
#    Then I should be on the welcome page
#    And I should see "Welcome to the Great Application"
#
#  Scenario: 'Accepting an invitation'
#    Given I am not currently logged in
#    And the "Boys and Girls Club" invites "mickey@monkees.com" to join
#    Then "mickey@monkees.com" should receive an email
#    When I open the email
#    Then I should see "Accept Invitation" in the email body
#    When I follow "Accept Invitation" in the email
#    Then I should be on the signup page
#    Then I should see "Sign Up"
#    And I fill in "Name (required)" with "Mickey Dolenz"
#    And the "Email (required)" field should contain "mickey@monkees.com"
#    And I fill in "Password (required)" with "password"
#    And I fill in "Password confirmation" with "password"
#    And I press "Register"
#    Then the account "mickey@monkees.com" should be "activated"
#    Then I should be on the accept/decline invitation page
#    And I should see "Join the Boys and Girls Club"

#  # https://github.com/bmabey/email-spec
#  # http://stackoverflow.com/questions/3467963/how-can-i-use-cucumber-to-test-devises-rememberable-functionality
#  @allow-rescue
#  Scenario: Create New Account (Everything cool)
#    Given I am not authenticated
#    When I go to register
#    And I fill in "Name" with "bill"
#    And I fill in "Email" with "bill@example.com"
#    And I fill in "Password" with "please"
#    And I fill in "Password Confirmation" with "please"
#    And I press "Sign up"
#    Then "bill@example.com" should receive an email
#    And I open the email
#    And I should see "Confirm my account" in the email body
#    When I follow "Confirm my account" in the email
#    Then I should see "Your account was successfully confirmed. You are now signed in."

