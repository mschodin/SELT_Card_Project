require 'rails_helper'
require 'spec_helper'

describe RoomController do
  describe 'creating a room' do
    it 'should create a new room when new room controller path is called' do
      unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
      expect(Room).to receive(:create!).with([id: unique_id.to_i])
      get :new
    end
    it 'should redirect to the newly created room when a new room is requested' do
      unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
      expect(room_path(unique_id)).to eq('/room/' + unique_id)
      get :new
    end
    it 'should create a new room with the correct id number created from current time' do
      get :new
      unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
      created_room = Room.find(unique_id.to_i)
      expect(created_room.id).to eq(unique_id.to_i)
    end
  end
end