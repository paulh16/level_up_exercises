Feature: Add Products to Shopping Cart
  As a customer
  I want to add products to my shopping cart
  In order to purchase them

  Background
    Given I am on a product page

  Scenario: Add An In-stock Product to the Cart (Good Path)
    And a product is in stock
    When I enter 1 in the "Product Quantity" box
    And I click "Add Product to Cart"
    Then I should have 1 product in my cart

  Scenario: Add an Out-of-stock Product to the Cart (Sad Path)
    And a product is out of stock
    When I enter 1 in the "Product Quantity" box
    And I "click Add Product to Cart"
    Then I should see "Sorry. That item is out of stock."

  Scenario: Add a Negative Quantity of Products to the Cart (Bad Path)
    And a product is in stock
    When I enter -1 in the "Product Quantity" box
    And I "click Add Product to Cart"
    Then I should see "Invalid Quantity. Please enter a number greater than zero."
