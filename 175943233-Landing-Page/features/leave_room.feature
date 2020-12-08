Feature: join a room from the landing page

  As a player
  I want to leave the game
  So that I can leave the application

  Scenario: The user leaves the game after joining

    Given I am in a room
    When I click the leave game button
    Then I should be redirected to the landing page