Feature: draw a card from a deck from the room page

  As a player
  I want to draw cards from the deck
  So that I can begin my turn

  Scenario: The user clicks Draw 1 Card

    Given I am on the game room home page AND a deck has been created
    When I click Draw 1 Card
    Then I should see the card that was drawn

  Scenario: The user does not click New Deck

    Given I am on the game room home page
    When I click create a new room with name "John"
    Then I should not see the Draw 1 Card button

  Scenario: The user clinks link to go back to room home page
    Given I am on the draw card room home page
    When I click link Return to Room
    Then I should see 1 less card in the deck