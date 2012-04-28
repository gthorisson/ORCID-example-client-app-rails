
Feature: Authentication with external account via OAuth
  In order to manage my account
  As a user
  I want to sign in with my existing account on an external site


  Scenario: Sign in with Twitter account
    Given I am on the signin page
    When I click the "Sign in with Twitter" link
    Then I should see ""

  Scenario: Sign in with LinkedIn account


  Scenario: Sign in with ORCID account


  Scenario: Log out
    Given I am signed in
    When I go to "the homepage"
    And I follow "Log out"
    Then I should see "Login via Twitter"
