Feature: see all player names in the room with their hand size

  As a player
  I want to see my family's names
  So that I know who is playing in the game

  Scenario: The user joins a game with players in it

    Given A room has been created
    And I am on the game room home page
    When I click join a room with name "John" and room id "1"
    Then I should see the room with a list of players and their hand size
    And I should NOT see the "John" in the list

  Scenario: The user is the first to join a game

    Given I am on the game room home page
    When I click create a new room with name "John"
    Then I should see the room with a an empty list of players
    And I should NOT see the "John" in the list