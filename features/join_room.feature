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

  Scenario: The user may not join a room with a duplicate name

    Given A room with id 1 has been created with player named "John" present
    And I am on the game room home page
    When I click join a room with name "John" and room id "1"
    Then The user is notified a player with name "John" already exists

  Scenario: The user enters invalid room code

    Given A room has been created
    And I am on the game room home page
    When I click join a room with name "John", room id "1", and room code "INCORRECT"
    Then The user is notified the room code is invalid