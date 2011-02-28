@refinerycms @site_bar
Feature: Site Bar
  In order to allow administrators to easily switch between editing and viewing their website
  I want logged in refinery users to see a site bar
  And I want logged in customers to not see a site bar

  Background:
    Given I have no site interactors
    And I have a page titled "Home" with a custom url "/"
    And A Refinery administrator exists
    And I am not logged in as an administrator

  Scenario: Not logged in
    When I go to the home page
    Then I should not see "Log out"

  Scenario: Logged in as an administrator
    Given I am a logged in refinery administrator
    When I go to the home page
    Then I should see "Log out"

  Scenario: Logged in as a user
    Given A site user exists
    And I am a logged in user
    When I go to the home page
    Then I should not see "Switch to your website editor"

