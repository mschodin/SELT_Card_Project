Feature: create a new room from the landing page

  As a player
  I want to create a deck
  So that I can specify deck structure

  Scenario:  The user has entered a room
    Given I am in a room
    When I click create a new deck
    Then I should see that a new deck is in the room