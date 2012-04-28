Feature: Registration
  As a user
  I want to register for an account on the site
  So I can log in
 
  Scenario: Register with username and password
    Given I am on the registration page
    When I fill in the registration form
    And click the Sign up button
    Then I should see "Welcome, your are now registered"
    And a user should exist with email: "gthorisson@gmail.com"
