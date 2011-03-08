@refinerycms @authentication @administrators @administrators-manage
Feature: Manage Administrators
  In order to control who can access my website's backend
  As an administrator
  I want to create and manage administrators

  Background:
    Given I have no site interactors

  Scenario: When there are no administrators, you are invited to create a administrator
    When I go to the home page
    Then I should see "There are no administrators yet, so we'll set you up first."

  @administrators-add @add
  Scenario: When there are no administrators, you can create an administrator
    When I go to the home page
    And I follow "Continue..."
    And I should see "Fill out your details below so that we can get you started."
    And I fill in "Username" with "cucumber"
    And I fill in "Email" with "green@cucumber.com"
    And I fill in "Password" with "greenandjuicy"
    And I fill in "Password confirmation" with "greenandjuicy"
    And I press "Sign up"
    Then I should see "Welcome to Refinery, cucumber."
    And I should see "Latest Activity"
    And I should have 1 administrator

  @administrators-list @list
  Scenario: Administrator List
    Given I have an administrator named "steven"
    And I am a logged in refinery administrator
    When I go to the list of administrators
    Then I should see "steven"

  @administrators-add @add
  Scenario: Create Administrator
    Given I have an administrator named "steven"
    And I am a logged in refinery administrator
    When I go to the list of administrators
    And I follow "Add new admin"
    And I fill in "Username" with "cucumber"
    And I fill in "Email" with "green@cucumber.com"
    And I fill in "Password" with "greenandjuicy"
    And I fill in "Password confirmation" with "greenandjuicy"
    And I press "Save"
    Then I should be on the list of administrators
    And I should see "cucumber was successfully added."
    And I should see "cucumber (green@cucumber.com)"

  @administrators-edit @edit
  Scenario: Edit Administrator
    Given I have an administrator named "steven"
    And I am a logged in refinery administrator
    When I go to the list of administrators
    And I follow "Edit this admin"
    And I fill in "Username" with "cucumber"
    And I fill in "Email" with "green@cucumber.com"
    And I press "Save"
    Then I should be on the list of administrators
    And I should see "cucumber was successfully updated."
    And I should see "cucumber (green@cucumber.com)"

  @lockable @administrators-lockable
  Scenario: Lock Account
    Given I have a refinery administrator named "steven"
    And I am a logged in refinery administrator
    And I go to the administrator account details for "steven"
    And I follow "Lock account"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully locked administrator account"
    And I should see "Account locked on"

  @lockable @administrators-lockable
  Scenario: Unlock Account
    Given I have a locked refinery administrator named "steven"
    And I am a logged in refinery administrator
    And I go to the administrator account details for "steven"
    And I follow "Unlock account"
    Then I should be on the administrator account details for "steven"
    And I should see "Administrator's account successfully unlocked"

  @lockable @administrators-lockable
  Scenario: Resend Unlock Instructions
    Given I have a locked refinery administrator named "steven"
    And I am a logged in refinery administrator
    And I go to the administrator account details for "steven"
    And I follow "Resend unlock instructions"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully resent account unlock instructions"

  @recoverable @administrators-recoverable
  Scenario: Generate Password Recovery Code
    Given I have a forgetful refinery administrator named "steven"
    And I am a logged in refinery administrator
    And I go to the administrator account details for "steven"
    And I follow "Generate new password reset code"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully created a new password reset code"

  @recoverable @administrators-recoverable
  Scenario: Resend Password Recovery Instructions
    Given I have a forgetful refinery administrator named "steven"
    And I am a logged in refinery administrator
    And I go to the administrator account details for "steven"
    And I follow "Email password reset instructions"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully created a new password reset code and emailed reset instruction to the administrator"

  @recoverable @administrators-recoverable
  Scenario: Delete Password Recovery Code
    Given I have a forgetful refinery administrator named "steven"
    And I am a logged in refinery administrator
    And I go to the administrator account details for "steven"
    And I follow "Delete password reset code"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully deleted password reset code"

  @recoverable @administrators-recoverable
  Scenario: Send Password Recovery Instructions
    Given I have a refinery administrator named "steven"
    And I am a logged in refinery administrator
    And I go to the administrator account details for "steven"
    And I follow "Email password reset instructions"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully created a new password reset code and emailed reset instruction to the administrator"
    And I follow "Administrator forgot password"
    And I should be on the administrator account details for "steven"

  @rememberable @administrators-rememberable
  Scenario: Invalidate Cookie
    Given I have a logged in and remembered administrator named "steven"
    And I go to the administrator account details for "steven"
    And I follow "Invalidate cookie"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully deleted remember cookie"

  @token_authenticatable @administrators-token_authenticatable
  Scenario: Generate New Token
    Given I am a logged in refinery administrator
    And Administrator token authentication is enabled
    And I have a refinery administrator named "steven"
    And I go to the administrator account details for "steven"
    And I follow "Generate new authentication token"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully generated a new authentication token"

  @token_authenticatable @administrators-token_authenticatable
  Scenario: Delete Authentication Token
    Given I am a logged in refinery administrator
    And Administrator token authentication is enabled
    And I have a refinery administrator named "steven"
    And I go to the administrator account details for "steven"
    And I follow "Delete authentication token"
    Then I should be on the administrator account details for "steven"
    And I should see "Successfully deleted authentication token"

