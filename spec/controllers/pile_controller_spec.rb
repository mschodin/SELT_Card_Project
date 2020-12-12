require 'rails_helper'
require 'spec_helper'

describe PileController do
  describe 'create a pile' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      @room = Room.create!(:id=>1)
      @unique_id = "1"
      Player.create!({:id=>1, :room_id=>@unique_id, :name=>"UniqueName"})
      @pile_id = "1"
    end
    it 'creates a pile when the create route is called' do
      post :create, :params => { :room_id => "1" }
      expect(Pile.all.length).to be(1)
    end
    it 'creates a pile with id of 1' do
      post :create, :params => { :room_id => "1" }
      expect(Pile.find(1)).to_not be_nil
    end
  end
end