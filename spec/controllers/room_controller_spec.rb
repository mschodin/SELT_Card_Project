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
    it 'should get all of the room items as a hash' do
      get :new
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

  end
end