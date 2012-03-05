Feature: Sort problems
  In order to find problems to solve more easily
  a user wants to sort problems by various columns

  @javascript
  Scenario: An external user sorts problems by title
    Given the following problems:
      | title  | difficulty | approved |
      | Test 4 | 1          | true     |
      | Test 3 | 1          | true     |
      | Test 2 | 1          | true     |
      | Test 1 | 1          | true     |
    When I go to the problems page
    And I sort by "Title"
    Then I should see problems in this order:
      | Test 1 | Easy       |
      | Test 2 | Easy       |
      | Test 3 | Easy       |
      | Test 4 | Easy       |

  @javascript
  Scenario: An external user sorts problems by difficulty
    Given the following problems:
      | title  | difficulty | approved |
      | Test 1 | 3          | true     |
      | Test 2 | 2          | true     |
      | Test 3 | 1          | true     |
      | Test 4 | 0          | true     |
    When I go to the problems page
    And I sort by "Difficulty"
    Then I should see problems in this order:
      | Test 4 | Elementary |
      | Test 3 | Easy       |
      | Test 2 | Medium     |
      | Test 1 | Hard       |
