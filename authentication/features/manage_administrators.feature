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

