Feature: Sort problems
  In order to find problems to solve more easily
  a user wants to sort problems by various columns

  Scenario: An external user sorts problems by title
    Given the following problems:
      | title  | difficulty |
      | Test 4 | 1          |
      | Test 3 | 1          |
      | Test 2 | 1          |
      | Test 1 | 1          |
    When I go to the problems page
    And I sort by title
    Then I should see problems in this order:
      | Test 1 | Easy       |
      | Test 2 | Easy       |
      | Test 3 | Easy       |
      | Test 4 | Easy       |

  Scenario: An external user sorts problems by difficulty
    Given the following problems:
      | title  | difficulty |
      | Test 1 | 3          |
      | Test 2 | 2          |
      | Test 3 | 1          |
      | Test 4 | 0          |
    When I go to the problems page
    And I sort by difficulty
    Then I should see problems in this order:
      | Test 4 | Elementary |
      | Test 3 | Easy       |
      | Test 2 | Medium     |
      | Test 1 | Hard       |
