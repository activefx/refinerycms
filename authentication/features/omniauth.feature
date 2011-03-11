@refinerycms @authentication @users @user @omniauth
Feature: Omniauth
  In order interact with restricted site content and features
  As a user
  I want to have access to authentication features through a 3rd party authentication

  Background:
    Given I have no users
    And A Refinery administrator exists
    And I have a page titled "Home" with a custom url "/"

#  Scenario: Twitter Login

