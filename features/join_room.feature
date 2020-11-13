Feature: join a room from the landing page

  As a player
  I want to join a game
  So that I can play cards with my family

  Scenario: The user joins a game with valid name and room id

    Given A room has been created
    And I am on the game room home page
    When I click join a room with name "John" and room id "1"
    Then I should be placed in the game room with id "1"

  Scenario: The user enters invalid name

    Given A room has been created
    And I am on the game room home page
    When I click join a room with name "" and room id "1"
    Then The user is notified their name is invalid

  Scenario: The user enters invalid room id

    Given A room has been created
    And I am on the game room home page
    When I click join a room with name "John" and room id ""
    Then The user is notified the room id is invalid

  Scenario: The user enters a room that does not exist

    Given A room has been created
    And I am on the game room home page
    When I click join a room with name "John" and room id "9999999999999"
    Then The user is notified the room does not exist