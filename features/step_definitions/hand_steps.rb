Given /^I am in a game room$/ do
  visit room_index_path
  click_button('Create a game')
end

When(/^There is a hand in play$/) do
  pending
end

Then(/^I should be able to get the contents of the hand$/) do
  pending
end