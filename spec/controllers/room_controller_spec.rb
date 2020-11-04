require 'rails_helper'
require 'spec_helper'

describe RoomController do
  describe 'creating a room' do
    it 'should create a new room when new room controller path is called' do
      unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
      expect(Room).to receive(:create!).with([id: unique_id.to_i])
      get :new
    end
  end
end