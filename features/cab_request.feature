@javascript
Feature: Requesting a cab
  In order to book a cab
  A requester
  Should submit a cab request form

  Background:
    Given  User is logged in
    And    Current User is not an Admin
    And    There is admin and vendor
    And    User is on the home page

  Scenario: Sends a valid Cab Request
    And    User fills in traveler_name as Cat
    And    User fills in contact_no as 1234567890
    And    User fills in pick_up_date as 07/02/9999
    And    User fills in pick_up_time as 11:30 PM
    And    User selects ThoughtWorks from drop down list source
    And    User selects Other from drop down list destination
    And    User fills in other_destination as India Gate
    And    User selects Indigo from drop down list vehicle_type
    And    Users have some previous requests
    When   User creates cab_request
    Then   User should be able to view all his CabRequests including this one
    And    User should be able to view XLS Sheet link

  Scenario: Sends an invalid Cab Request
    And    User fills in traveler_name as Cat
    And    User fills in contact_no as 123
    And    User fills in pick_up_date as 07/02/9999
    And    User fills in pick_up_time as 11:30 PM
    And    User selects ThoughtWorks from drop down list source
    And    User selects Other from drop down list destination
    And    User fills in other_destination as India Gate
    When   User creates cab_request
    Then   User should be able to view cab_request form with pre-filled fields and an appropriate error message

  Scenario: Sends a valid Cab Request with destination Airport
    And    User fills in traveler_name as Cat
    And    User fills in contact_no as 1234567890
    And    User fills in pick_up_date as 07/02/9999
    And    User fills in pick_up_time as 11:30 PM
    And    User selects ThoughtWorks from drop down list source
    And    User selects Airport from drop down list destination
    And    User fills in flight_number_destination as 9W123
    And    User selects Indigo from drop down list vehicle_type
    And    Users have some previous requests
    When   User creates cab_request
    Then   User should be able to view all his CabRequests including this one
    And    User should be able to view XLS Sheet link

  Scenario: Sends a valid Cab Request with destination Guest house
    And    User fills in traveler_name as Cat
    And    User fills in contact_no as 1234567890
    And    User fills in pick_up_date as 07/02/9999
    And    User fills in pick_up_time as 11:30 PM
    And    User selects ThoughtWorks from drop down list source
    And    User selects Guest House from drop down list destination
    And    User selects A-408, Sushant Lok-1, Next to Plaza Mall, Opp Westin Hotel from drop down list guest_house_destination
    And    User selects Swift from drop down list vehicle_type
    And    Users have some previous requests
    When   User creates cab_request
    Then   User should be able to view all his CabRequests including this one
    And    User should be able to view XLS Sheet link

  Scenario: Sends a valid Cab Request with other travellers
    And    User fills in traveler_name as Cat
    And    User fills in contact_no as 1234567890
    And    User fills in pick_up_date as 07/02/9999
    And    User fills in pick_up_time as 11:30 PM
    And    User selects ThoughtWorks from drop down list source
    And    User selects Guest House from drop down list destination
    And    User selects A-408, Sushant Lok-1, Next to Plaza Mall, Opp Westin Hotel from drop down list guest_house_destination
    And    User selects Swift from drop down list vehicle_type
    And    User fills in project as Jack, Jill
    And    Users have some previous requests
    When   User creates cab_request
    Then   User should be able to view all his CabRequests including this one
    And    User should be able to view XLS Sheet link
#  Scenario: Sends a blank Cab Request
#    When   User creates cab_request
#    Then   User should be able to view cab_request form with blank fields and appropriate error messages