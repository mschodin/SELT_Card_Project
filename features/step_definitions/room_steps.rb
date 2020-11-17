Given /^I am on the game room home page$/ do
  visit room_index_path
end

Given /^A room has been created$/ do
  visit room_index_path
  page.fill_in "create_name_box", :with => "UncommonName"
  click_button('Create Game')
end

Given /^A room with id 1 has been created with player named "(.*?)" present$/ do |name|
  visit room_index_path
  if Room.last.id.eql?(0)
    page.fill_in "create_name_box", :with => name
    click_button('Create Game')
  else
    page.fill_in "join_name_box", :with => name
    page.fill_in 'room_id_box', :with => 1
    click_button('Join Game')
  end
end

When /^I click create a new room with name "(.*?)"$/ do |name|
  page.fill_in "create_name_box", :with => name
  click_button('Create Game')
end

Then /^I should be placed in a new game room with name "(.*?)"$/ do |name|
  url = URI.parse(current_url)
  unique_id = Room.last.id.to_s
  expect(url.path).to eq('/room/' + unique_id)
  page.should have_content('Player name: ' + name)
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

Then /^The user is notified a player with name "(.*?)" already exists$/ do |name|
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content("Player with name " + name + " already exists in room 1")
end

When /^I click the leave game button$/ do
  click_button('Leave Game')
end

Then /^I should be redirected to the landing page$/ do
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
end