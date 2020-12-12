Feature: Delete Room

  As a host
  I want to end the game
  So that players leave the application

  Scenario: The user ends the game

    Given I am in a room
    When I click End Game
    Then I should be redirected to the landing page
    