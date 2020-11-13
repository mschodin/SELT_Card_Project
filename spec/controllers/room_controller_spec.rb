require 'rails_helper'
require 'spec_helper'

describe RoomController do
  describe 'creating a room' do
    it 'should create a new room when new room controller path is called' do
      unique_id = Room.last.id
      expect(Room).to receive(:create!)
      room = assigns(:room)
      allow(room).to receive(:id).and_return(unique_id)
      allow(room).to receive(:add_player)
      post :create, :params => {:name => "John"}
    end
    it 'should redirect to the newly created room when a new room is requested' do
      unique_id = Room.last.id.to_s
      expect(room_path(unique_id)).to eq('/room/' + unique_id)
      post :join, :params => { :name => "John", :room_id => "9999999999"}
    end
  end
  describe 'showing a room and its contents' do
    it 'should get all of the room items as a hash' do
      post :create, :params => {:name => "John"}
      get :show, params: {:id=>1}, session: {:room_id=>1}
      allow(controller).to receive(:get_room)

      room = assigns(:room)
      deck_db = room.decks.create({:room_id=>1})
      deck = Deck.create_deck
      deck.shuffle!
      deck.each do |card|
        deck_db.cards.create(card)
      end
      cards = assigns(:items)

      items = controller.get_room_items(cards)
      items.each do |key,deck|
        expect(deck).to be_a(Array)
        deck.each do |cards|
          expect(cards).to be_a(Hash)
        end
      end
    end
  end
  describe 'join a room' do
    # render_views
    before(:all) do
      Room.create!
    end
    it 'joins room with valid id' do
      # post '/room/join', :params => { :name => "John", :room_id => "1"}
      post :join, :params => { :name => "John", :room_id => "1"}
      # expect(response).to render_template('show')
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
    # it 'prevents joining a room when selected player name is already in that given room' do
    #   post :join, :params => { :name => "John", :room_id => "1"}
    #   post :join, :params => { :name => "John", :room_id => "1"}
    #   expect(response).to_not redirect_to(room_path(1))
    # end
  end
end