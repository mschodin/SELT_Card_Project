Given /^I am on the game room home page$/ do
  visit room_index_path
end

When /^I click create a new room$/ do
  click_button('Create a game')
end

Then /^I should be placed in a new game room$/ do
  url = URI.parse(current_url)
  unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
  expect(url.path).to eq('/room/' + unique_id)
end