require 'rails_helper'
require 'spec_helper'

describe RoomController do
  describe 'creating a room' do
    it 'should create a new room when new room controller path is called' do
      unique_id = 1
      expect(Room).to receive(:create!).with(no_args)
      room = assigns(:room)
      allow(room).to receive(:id).and_return(unique_id)
      get :new
    end
    it 'should redirect to the newly created room when a new room is requested' do
      unique_id = '1'
      expect(room_path(unique_id)).to eq('/room/' + unique_id)
      get :new
    end
    it 'should create a new room with the correct id number created from current time' do
      get :new
      unique_id = 1
      created_room = Room.find(unique_id)
      expect(created_room.id).to eq(unique_id)
    end
  end
  describe 'showing a room and its contents' do
    it 'should display the new deck button' do

    end
    it 'should show the draw card button if a deck exists' do

    end
    it 'should get all of the room items if they exist' do

    end
    it 'should not show the draw card button if no room items (deck) exist' do

    end
  end
end