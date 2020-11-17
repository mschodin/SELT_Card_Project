Given(/^I am in a room$/) do
  visit room_index_path
  page.fill_in "create_name_box", :with => "UncommonName"
  click_button('Create Game')
  click_button('New Pile')
end

When(/^I click create a new deck$/) do
  click_button('New Deck in Pile 1')
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


Given(/^I am on the game room home page AND a deck has been created$/) do
  visit room_index_path
  page.fill_in "create_name_box", :with => "UncommonName"
  click_button('Create Game')
  click_button('New Pile')
  click_button('New Deck in Pile 1')
end

When(/^I click Draw (\d+) Card$/) do |arg|
  click_button('Draw 1 Card')
end

Then(/^I should see the card that was drawn$/) do
  cards =  page.all('td').map { |td| td.text }
  expect(cards).to include match "Suit"
  expect(cards).to include match "Rank"
  suits = %w[Diamonds Spades Clubs Hearts]
  ranks = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
  expect(suits).to include cards[-1]
  expect(ranks).to include cards[2]
end

Then(/^I should not see the Draw (\d+) Card button$/) do |arg|
  expect(page).not_to have_button('Draw 1 Card')
end

Given(/^I am on the draw card room home page$/) do
  visit room_index_path
  page.fill_in "create_name_box", :with => "UncommonName"
  click_button('Create Game')
  click_button('New Pile')
  click_button('New Deck in Pile 1')
  click_button("Draw 1 Card from Pile 1")
end

When(/^I click link Return to Room$/) do
  click_link("Return to Room")
end

Then(/^I should see (\d+) less card in the deck$/) do |arg|
  expect(page).to have_content("CARDS IN FIRST DECK: " + (RubyCards::Deck.new.count - 1).to_s)
end