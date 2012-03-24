Feature: Checkout

  In order to sell my products
  I want to be able add up items sold with given pricing rules

  Background:
    Given I seeded the following products:
      | product_code | name         | price  |
      | FR1          | Fruit tea    |  3.11  |
      | SR1          | Strawberries |  5.0  |
      | CF1          | Coffee       | 11.23  |
    And I seeded the following pricing rules:
      |  discount_type | product_code | bulk_threshold | bulk_price |
      |  bogof         | FR1          |                |            |
      |  bulk          | SR1          |  3             |    4.50    |

  @javascript
  Scenario: Creating a checkout without pricing rules and adding an item
    When I go to the home page
    And I create a new checkout without offers
    Then I can see a blank checkout
    And I can see the list of available pricing rules applied
    When I add an any item
    Then the items gets listed as transaction
    When I choose add up the bill
    Then I can see a total checkout value

  @javascript
  Scenario: Creating a checkout with pricing rules and a given basket
    When I go to the home page
    And I create a new checkout with all pricing rules
    Then I can see a checkout with the pricing rules listed
    Given I add the following items "FR1", "SR1", "FR1", "FR1" and "CF1"
    And I choose add up the bill
    Then I can see the total checkout value 22.45

  @javascript
  Scenario: Creating a checkout with pricing rules and a given basket
    When I go to the home page
    And I create a new checkout with all pricing rules
    Then I can see a checkout with the pricing rules listed
    Given I add the following items "FR1", "FR1"
    And I choose add up the bill
    Then I can see the total checkout value 3.11

  @javascript
  Scenario: Creating a checkout with pricing rules and a given basket
    When I go to the home page
    And I create a new checkout with all pricing rules
    Then I can see a checkout with the pricing rules listed
    Given I add the following items "SR1", "SR1", "FR1" and "SR1"
    And I choose add up the bill
    Then I can see the total checkout value 16.61


