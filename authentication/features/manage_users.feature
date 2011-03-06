@refinerycms @authentication @users @users-manage
Feature: Manage Users
  In order to control who can access my website's backend
  As an administrator
  I want to create and manage users

  Background:
    Given I have no users

  @users-list @list
  Scenario: User List
    Given I have a user named "steven"
    And I am a logged in refinery administrator
    When I go to the list of users
    Then I should see "steven"

  @users-add @add
  Scenario: Create User
    Given I have a user named "steven"
    And I am a logged in refinery administrator
    When I go to the list of users
    And I follow "Add new user"
    And I fill in "Username" with "cucumber"
    And I fill in "Email" with "green@cucumber.com"
    And I fill in "Password" with "greenandjuicy"
    And I fill in "Password confirmation" with "greenandjuicy"
    And I press "Save"
    Then I should be on the list of users
    And I should see "cucumber was successfully added."
    And I should see "cucumber (green@cucumber.com)"

  @users-edit @edit
  Scenario: Edit User
    Given I have a user named "steven"
    And I am a logged in refinery administrator
    When I go to the list of users
    And I follow "Edit this user"
    And I fill in "Username" with "cucumber"
    And I fill in "Email" with "green@cucumber.com"
    And I press "Save"
    Then I should be on the list of users
    And I should see "cucumber was successfully updated."
    And I should see "cucumber (green@cucumber.com)"

  @confirmable @users-confirmable
  Scenario: Confirm User
    Given I have a user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Confirm this user"
    Then I should be on the account details for "steven"
    And I should see "User was successfully confirmed"

  @confirmable @users-confirmable
  Scenario: Resend Confirmation
    Given I have a user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Resend confirmation instructions"
    Then I should be on the account details for "steven"
    And I should see "Confirmation instructions successfully resent"

  @confirmable @users-confirmable
  Scenario: Confirmed User
    Given I have a site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Account confirmed"
    Then I should be on the account details for "steven"

  @lockable @users-lockable
  Scenario: Lock Account
    Given I have a site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Lock account"
    Then I should be on the account details for "steven"
    And I should see "Successfully locked user account"
    And I should see "Account locked on"

  @lockable @users-lockable
  Scenario: Unlock Account
    Given I have a locked site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Unlock account"
    Then I should be on the account details for "steven"
    And I should see "User's account successfully unlocked"

  @lockable @users-lockable
  Scenario: Resend Unlock Instructions
    Given I have a locked site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Resend unlock instructions"
    Then I should be on the account details for "steven"
    And I should see "Successfully resent account unlock instructions"

  @recoverable @users-recoverable
  Scenario: Generate Password Recovery Code
    Given I have a forgetful site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Generate new password reset code"
    Then I should be on the account details for "steven"
    And I should see "Successfully created a new password reset code"

  @recoverable @users-recoverable
  Scenario: Resend Password Recovery Instructions
    Given I have a forgetful site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Email password reset instructions"
    Then I should be on the account details for "steven"
    And I should see "Successfully created a new password reset code and emailed reset instruction to the user"

  @recoverable @users-recoverable
  Scenario: Delete Password Recovery Code
    Given I have a forgetful site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Delete password reset code"
    Then I should be on the account details for "steven"
    And I should see "Successfully deleted password reset code"

  @recoverable @users-recoverable
  Scenario: Send Password Recovery Instructions
    Given I have a site user named "steven"
    And I am a logged in refinery administrator
    And I go to the account details for "steven"
    And I follow "Email password reset instructions"
    Then I should be on the account details for "steven"
    And I should see "Successfully created a new password reset code and emailed reset instruction to the user"
    And I follow "User forgot password"
    And I should be on the account details for "steven"

  @rememberable @users-rememberable
  Scenario: Invalidate Cookie
    Given I am a logged in refinery administrator
    And I have a logged in and remembered user named "steven"
    And I go to the account details for "steven"
    And I follow "Invalidate cookie"
    Then I should be on the account details for "steven"
    And I should see "Successfully deleted remember cookie"

  @token_authenticatable @users-token_authenticatable
  Scenario: Generate New Token
    Given I am a logged in refinery administrator
    And User token authentication is enabled
    And I have a site user named "steven"
    And I go to the account details for "steven"
    And I follow "Generate new authentication token"
    Then I should be on the account details for "steven"
    And I should see "Successfully generated a new authentication token"

  @token_authenticatable @users-token_authenticatable
  Scenario: Delete Authentication Token
    Given I am a logged in refinery administrator
    And User token authentication is enabled
    And I have a site user named "steven"
    And I go to the account details for "steven"
    And I follow "Delete authentication token"
    Then I should be on the account details for "steven"
    And I should see "Successfully deleted authentication token"

