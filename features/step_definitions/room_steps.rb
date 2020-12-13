Given /^I am on the game room home page$/ do pending
  visit room_index_path
end

Given /^A room has been created$/ do pending
  visit room_index_path
  page.fill_in "create_name", :with => "UncommonName"
  page.
  click_button('Create Game')
end

Given /^A room with id 1 has been created with player named "(.*?)" present$/ do |name| pending
  visit room_index_path
  if Room.last.nil? || Room.last.id.eql?(0)
    page.fill_in "create_name", :with => name
    click_button('Create Game')
  else
    code = Room.exists?(id) ? Room.find(id).code : ""
    page.fill_in "join_name_box", :with => name
    page.fill_in 'room_id_box', :with => 1
    page.fill_in 'room_code_box', :with => code
    click_button('Join Game')
  end
end

When /^I click create a new room with name "(.*?)"$/ do |name| pending
  page.fill_in "create_name", :with => name
  click_button('Create Game')
end

Then /^I should be placed in a new game room with name "(.*?)"$/ do |name| pending
  url = URI.parse(current_url)
  unique_id = Room.last.id.to_s
  expect(url.path).to eq('/room/' + unique_id)
  page.should have_content(name + ' is in private room ')
end

When /^I click join a room with name "(.*?)" and room id "(.*?)"$/ do |name, id| pending
  code = Room.exists?(id) ? Room.find(id).code : ""
  page.fill_in "join_name_box", :with => name
  page.fill_in 'room_id_box', :with => id
  page.fill_in 'room_code_box', :with => code
  click_button('Join Game')
end

Then /^I should be placed in the game room with id "(.*?)"$/ do |id| pending
  url = URI.parse(current_url)
  expect(url.path).to eq('/room/' + id)
end

Then /^The user is notified their name is invalid$/ do pending
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content('Name is invalid, please try again')
end

Then /^The user is notified the room id is invalid$/ do pending
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content('Room id invalid, please try again')
end

Then /^The user is notified the room does not exist$/ do pending
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content('Room does not exist, please try again')
end

Then /^The user is notified a player with name "(.*?)" already exists$/ do |name| pending
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content("Player with name " + name + " already exists in room 1")
end

When /^I click the leave game button$/ do pending
  click_button('Leave Game')
end

Then /^I should be redirected to the landing page$/ do pending
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
end

Then(/^I should see the room with a list of players and their hand size$/) do pending
  table_list = page.all('table td:nth-child(2)').map{|td| td.text}
  table_list = table_list.map {|x| x[/\d+/]}
  expect(table_list.count).to be >= 1
  table_list.uniq.each do |count|
    expect(count.to_i).to eq(0)
  end
end

And(/^I should NOT see the "(.*?)" in the list$/) do |name| pending
  table_list = page.all('table td:nth-child(1)').map{|td| td.text}
  expect(table_list).to_not include(name)
end

Then(/^I should see the room with a an empty list of players$/) do pending
  table_list = page.all('table td:nth-child(1)').map{|td| td.text}
  expect(table_list).to eq([])
end

When /^I click join a room with name "(.*?)", room id "(.*?)", and room code "(.*?)"$/ do |name, id, code| pending
  page.fill_in "join_name_box", :with => name
  page.fill_in 'room_id_box', :with => id
  page.fill_in 'room_code_box', :with => code
  click_button('Join Game')
end

Then /^The user is notified the room code is invalid$/ do pending
  url = URI.parse(current_url)
  expect(url.path).to eq('/room')
  page.should have_content('Room code invalid, please try again')
end

And /^I should see the room code$/ do pending
  code = Room.last.code
  div = find('[data-react-class="RoomAppBar"]') #gets react component RoomAppBar
  div[:'data-react-props'].should have_content('Room-code: ' + code)
end

When(/^I click End Game$/) do pending
  click_button('End Game')
end
