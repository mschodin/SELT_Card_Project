Given(/^I am in a room$/) do
  visit room_index_path
  click_button('Create a game')
end

When(/^I click create a new deck$/) do
  click_button('New Deck')
end

Then(/^I should see that a new deck is in the room$/) do
  cards =  page.all('tr').map { |td| td.text }
  expect(cards).to include match "Rank"
  expect(cards).to include match "Suit"
  expect(cards).to include match "Diamond"
  expect(cards).to include match "Spades"
  expect(cards).to include match "Hearts"
  expect(cards).to include match "Club"
end
