@refinerycms @authentication @users @user
Feature: User
  In order interact with restricted site content and features
  As a user
  I want to have access to authentication features

  Background:
    Given I have no users
    And A Refinery administrator exists
    And I have a page titled "Home" with a custom url "/"

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

#  @users-password-forgot
#  Scenario: Forgot Password page (no email entered)
#    And I am on the forgot password page
#    When I press "Reset password"
#    Then I should see "You did not enter an email address."

#  @users-password-forgot
#  Scenario: Forgot Password page (non existing email entered)
#    Given I am on the forgot password page
#    And I have a user with email "green@cukes.com"
#    When I fill in "user_email" with "none@cukes.com"
#    And I press "Reset password"
#    Then I should see "Sorry, 'none@cukes.com' isn't associated with any accounts."
#    And I should see "Are you sure you typed the correct email address?"

#  @users-password-forgot
#  Scenario: Forgot Password page (existing email entered)
#    Given I am on the forgot password page
#    And I have a user with email "green@cukes.com"
#    When I fill in "user_email" with "green@cukes.com"
#    And I press "Reset password"
#    Then I should see "An email has been sent to you with a link to reset your password."

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

