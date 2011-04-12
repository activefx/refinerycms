@refinerycms @authentication @users @database_authenticatable
Feature: Database Authenticatable (Sign In / Sign Out)
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign in and sign out

  Background:
    Given I have no users
    And A Refinery administrator exists
    And I have a page titled "Home" with a custom url "/"

    Scenario: Home Page
      When I go to the home page
      Given No one is logged in
      Then I should see "Sign In"
      And I should see "Register"

    Scenario: Login (successful login)
      Given I am on the login page
      And I have a site user named "user"
      And I fill in "user_login" with "user"
      And I fill in "user_password" with "password"
      And I press "Sign in"
      Then I should see "Signed in as user"
      And I should be on the user root

    Scenario: Login (user not signed up)
      Given I am a visitor
      When I am on the login page
      And I fill in "user_login" with "user"
      And I fill in "user_password" with "password"
      And I press "Sign in"
      Then I should see "Sorry, your login or password was incorrect."
      And I should be signed out

    Scenario: Login (wrong password)
      Given I am on the login page
      And I have a site user named "user"
      And I fill in "user_login" with "user"
      And I fill in "user_password" with "aksdfjlkdsjflk"
      And I press "Sign in"
      Then I should see "Sorry, your login or password was incorrect."

    Scenario: Logout
      Given I am a logged in user
      And I am on the home page
      And I follow "Sign Out"
      Then I should be on the home page
      And I should not see "Sign Out"

