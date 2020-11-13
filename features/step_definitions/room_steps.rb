Given /^I am on the game room home page$/ do
  visit room_index_path
end

Given /^A room has been created$/ do
  visit room_index_path
  click_button('Create a game')
end

When /^I click create a new room$/ do
  click_button('Create a game')
end

Then /^I should be placed in a new game room$/ do
  url = URI.parse(current_url)
  unique_id = Room.last.id.to_s
  expect(url.path).to eq('/room/' + unique_id)
end

When /^I click join a room with name "(.*?)" and room id "(.*?)"$/ do |name, id|
  page.fill_in "join_name_box", :with => name
  page.fill_in 'room_id_box', :with => id
  click_button('Join Game')
end

Then /^I should be placed in the game room with id "(.*?)"$/ do |id|
  url = URI.parse(current_url)
  expect(url.path).to eq('/room/' + id)
end

Then /^The user is notified their name is invalid$/ do
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content('Name is invalid, please try again')
end

Then /^The user is notified the room id is invalid$/ do
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content('Room id invalid, please try again')
end

Then /^The user is notified the room does not exist$/ do
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content('Room does not exist, please try again')
end