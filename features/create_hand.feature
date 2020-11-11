Feature: Create a hand to store cards

  As a player
  I want to have cards in a hand
  so that I can play games

Scenario: A Player has been created
  Given I am in a game room
  When There is a hand in play
  Then I should be able to get the contents of the hand