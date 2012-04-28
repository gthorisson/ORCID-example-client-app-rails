
Feature: Authentication with local user account
  In order to manage my account
  As a user
  I want to sign in with my username and password

  Background:
 
  Scenario: Sign in
    Given a user exists with email: "gthorisson@gmail.com", password: "ffffff"
    And I am on the signin page
    When I fill in the login form
    And I click the Sign in button
    Then I should see "Signed in successfully"


  Scenario: Sign in with Twitter account
    Given I am on the signin page
    When I click the "Sign in with Twitter" link
    Then 

  Scenario: Sign out
