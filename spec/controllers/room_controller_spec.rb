require 'rails_helper'
require 'spec_helper'

describe RoomController do
  describe 'creating a room' do
    it 'should create a new room when new room controller path is called' do
      unique_id = Room.last.id
      room = assigns(:room)
      expect(Room).to receive(:create!)
      allow(room).to receive(:id).and_return(unique_id)
      allow(room).to receive(:add_player)
      post :create, :params => {:name => "John"}
    end
    it 'should redirect to the newly created room when a new room is requested' do
      unique_id = Room.last.id.to_s
      expect(room_path(unique_id)).to eq('/room/' + unique_id)
      post :join, :params => { :name => "John", :room_id => "9999999999"}
    end
    it 'should not allow creating a room with an invalid name' do
      expect(Room).to_not receive(:create!)
      post :create, :params => {:name => "John!@%!@"}
    end
    it 'should not allow creating a room with an empty name' do
      expect(Room).to_not receive(:create!)
      post :create, :params => {:name => ""}
    end
  end
  describe 'showing a room and its contents' do
    it 'should get all of the room items as a hash' do
      post :create, :params => {:name => "John"}
      get :show, params: {:id=>1}, session: {:room_id=>1}
      allow(controller).to receive(:get_room)

      room = assigns(:room)
      pile = room.piles.create({:room_id=>1})
      deck_db = pile.decks.create({:pile_id=>1})
      deck = Deck.create_deck
      deck.shuffle!
      deck.each do |card|
        deck_db.cards.create(card)
      end
      cards = assigns(:items)

      items = controller.get_room_items(room.piles.all)
      items.each do |key,deck|
        expect(deck).to be_a(Array)
        deck.each do |cards|
          expect(cards).to be_a(Hash)
        end
      end
    end
  end
  describe 'join a room' do
    before(:all) do
      Player.destroy_all
      Room.create!
      Player.create!(:name=>"NameTaken", :room_id=>1)
    end
    it 'joins room with valid id' do
      post :join, :params => { :name => "John", :room_id => "1"}
      expect(response).to redirect_to(room_path(1))
    end
    it 'prevents join when invalid name is given' do
      post :join, :params => { :name => "John#^#&", :room_id => "1"}
      expect(response).to_not redirect_to(room_path(1))
      post :join, :params => { :name => "", :room_id => "1"}
      expect(response).to_not redirect_to(room_path(1))
    end
    it 'prevents join when invalid room id is given' do
      post :join, :params => { :name => "John", :room_id => "roomid"}
      expect(response).to_not redirect_to(room_path(1))
      post :join, :params => { :name => "John", :room_id => ""}
      expect(response).to_not redirect_to(room_path(1))
    end
    it 'prevents join when room id given does not exist' do
      post :join, :params => { :name => "John", :room_id => "9999999999"}
      expect(response).to_not redirect_to(room_path(1))
    end
    it 'prevents joining a room when selected player name is already in that given room' do
      post :join, :params => { :name => "NameTaken", :room_id => "1"}
      expect(response).to_not redirect_to(room_path(1))
    end
  end
  describe 'leave a room' do
    before(:each) do
      Player.destroy_all
      Room.create!
      Player.create!(:id=>1, :name=>"John", :room_id=>"1")
    end
    it 'destroys player model when a player leaves' do
      get :leave, params: {:action=>"leave", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(Player.exists?(1)).to be_falsy
    end
    it 'redirects to the landing page when a player leaves' do
      get :leave, params: {:action=>"leave", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(response).to redirect_to(room_index_path)
    end
  end
end