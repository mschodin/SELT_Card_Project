Feature: create a new room from the landing page

  As a player
  I want to host a game
  So that I can play with my family

Scenario: The user has arrived at the landing page

  Given I am on the game room home page
  When I click create a new room with name "John"
  Then I should be placed in a new game room with name "John"
  And I should see the room code