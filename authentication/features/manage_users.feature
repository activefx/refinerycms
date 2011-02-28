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

