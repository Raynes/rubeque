Feature: Submit solutions
  In order to learn ruby and compete against other users
  a user
  wants to submit solutions to problems

  @javascript
  Scenario: An external user submits a solution
    When I go to the problem page for "The Truth"
    And I fill in "false" for the solution code
    And I submit the solution
    Then I should see an error message
    When I reset the solution code
    And I fill in "true" for the solution code
    And I submit the solution
    Then I should see a success message
    And there should not be a new solution in the database

  Scenario: A logged in user submits a solution without javascript
    Given I am logged in as a user named "advorak"
    When I go to the problem page for "The Truth"
    When I fill in "true" for the solution code
    And I submit the solution
    Then I should see a success message
    And there should be a new solution in the database

  @javascript
  Scenario: A user tries to submit malicious code
    Given I am logged in as a user named "fliszt"
    When I go to the problem page for "The Truth"
    When I fill in "Kernel.exit!" for the solution code
    And I submit the solution
    Then I should see a "SystemExit" error message
