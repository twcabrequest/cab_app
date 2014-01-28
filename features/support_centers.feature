Feature: Managing admin/vendor
  In order to manage admin & vendor
  A user
  Should be able to view and update admins/vendors

  Background:
    Given User is logged in

  Scenario: Requester views active admin/vendor
    And   Current User is not an Admin
    And   There are admins and vendors
    And   User is on the support centers page
    Then  User should be able to view active admin & active vendor


