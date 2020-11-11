Feature: Create a hand to store cards

  As a player
  I want to have cards in a hand
  so that I can play games

Scenario: A Player has been created
  Given There is an empty hand in play
  Then There should be an empty hand

  Given There is non-empty hand in play
  Then I should have a non-empty hand