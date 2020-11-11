
Given(/^There is an empty hand in play$/) do
  @hand0 = GameHand.new()
end


Then(/^There should be an empty hand$/) do
  expect(@hand1.empty?).to be_falsy?
end

Given(/^There is non\-empty hand in play$/) do
  @hand0 = GameHand.new()
  @deck0 = RubyCards::Deck.new()
  @hand0.draw_card(@deck0, 5)
end

Then(/^I should have a non\-empty hand$/) do
  expect(@hand1.empty?).to be_truthy
end