@refinerycms @authentication @users @user @omniauth
Feature: Omniauth
  In order interact with restricted site content and features
  As a user
  I want to have access to authentication features through a 3rd party authentication

  Background:
    Given I have no users
    And A Refinery administrator exists
    And I have a page titled "Home" with a custom url "/"

  Scenario: Twitter Signup Redirects to Registration (if not enough user information)
    When I login with twitter
    Then I should see "Please complete your registration"
    And the "user_username" field should contain "episod"

  Scenario: Complete Twitter Registration (if not enough user information)
    When I login with twitter
    And I fill in "user_email" with "user123@example.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I press "Sign up"
    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed"

  Scenario: Twitter Login (user already has a token)
    When I have a user "some_user" with a "twitter" token with a uid of "819797"
    And I login with twitter
    Then I should see "Successfully authorized from twitter account."
    And I should see "Signed in as some_user"

  Scenario: Twitter Logout
    When I am logged in with twitter
    And I follow "Sign Out"
    Then I should be on the home page
    And I should not be logged in

  # Feature Works But Is Losing Current User in Testing
  #  @omni
  #  Scenario: Connect Twitter Account When Signed In
  #    When I am a logged in user
  #    And I go to the edit registration page
  #    And I link my twitter account
  #    Then Display the page
  #    And I should be on the edit registration page
  #    And I should see "Successfully enabled twitter authentication."
  #    And I should see "Twitter" within "linked_services"

  Scenario: Remove Twitter Account
    When I have a user "some_user" with a "twitter" token with a uid of "819797"
    And I am a logged in user
    And I go to the edit registration page
    And I follow "remove"
    Then I should see "Successfully removed twitter authentication."
    And I should be on the edit registration page
    And I should see "You haven't linked any services"

  Scenario: Facebook First Login (required user information is included)
    When I login with facebook
    Then I should see "Successfully authorized from facebook account."
    And I should see "Signed in as josevalim"
    And "user456@example.com" should have been created by omniauth

  Scenario: Facebook First Login (user already has an account)
    When I have a user with email "user456@example.com"
    And I login with facebook
    Then I should see "Successfully authorized from facebook account."
    And I should see "Signed in as person"
    And "user456@example.com" should not have been created by omniauth

  Scenario: Unsuccessful Facebook Login (invalid credentials)
    When I fail to login with facebook due to invalid credentials
    Then I should see "Could not authorize you from Facebook"
    And I should be on the login page
    And I should not be logged in

  Scenario: Unsuccessful Facebook Login (access denied)
    When I fail to login with facebook due to access denied
    Then I should see "Could not authorize you from Facebook"
    And I should be on the login page
    And I should not be logged in

  Scenario: Facebook Logout
    When I am logged in with facebook
    And I follow "Sign Out"
    Then I should be on the home page
    And I should not be logged in

