
Feature: Test the content on each of the catalog pages


  Scenario: Navigate from the My Account Page to the Order History Page
    Given I am on the My Account Page
    When I click the Order History Button
    Then I should see the Order History Page


  Scenario: Navigating from the My Account Page to the Credit Slips Page
    Given I am on the My Account Page
    When I click the My Credit Slips Button
    Then I should see the Credit Slips Page


  Scenario: Navigating from the My Account Page to the My Addresses Page
    Given I am on the My Account Page
    When I click the My Addresses Button
    Then I should see the My Addresses Page


  Scenario: Navigating from the My Account Page to the Personal Information Page
    Given I am on the My Account Page
    When I click the My Personal Information Button
    Then I should see the Personal Information Page


  Scenario Outline: Navigation on the My Account Page
    Given I am on the My Account Page
    When I click the <account option> button
    Then I should see the <page> Page

  Examples:
    | account option          | page                 |
    | order history           | Order History        |
    | my credit slips         | Credit Slips         |
    | my addresses            | My Addresses         |
    | my personal information | Personal Information |
#    | my wishlists            | My Wishlists         | #TODO: Add this page