require 'rails_helper'
require 'spec_helper'

describe DeckController do
  describe 'drawing one card' do
    it 'should redirect to drawing view' do
      unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
      Room.create!([:id => unique_id.to_i])
      expect(room_deck_draw_path(:deck_id=>1, :room_id=>unique_id)).to eq('/room/' + unique_id + '/deck/1/draw')
      get :create, params: {"room_id"=>unique_id}
      get :draw, params: {:deck_id=>"1", :room_id=>unique_id}, session: {:room_id=>unique_id}
    end
    it 'should have a deck of cards to draw from' do
      unique_id = 1
      room = Room.create!([:id=>unique_id])
      deck = RubyCards::Deck.new
      get :create, params: {"room_id"=>unique_id}
      expect(assigns(:deck).count).to be(deck.count)
    end
    it 'return the room items as a hash' do
      unique_id = 1
      Room.create!([:id => unique_id])
      get :create, params: {"room_id"=>unique_id}
      room = Room.find(unique_id)
      cards = room.cards.all
      get :draw, params: {:deck_id=>"1", :room_id=>unique_id}, session: {:room_id=>unique_id}
      allow(controller).to receive(:get_room_items).with(cards)
      items = assigns(:room_items)
      items.each do |key,deck|
        expect(deck).to be_a(Array)
        deck.each do |cards|
          expect(cards).to be_a(Hash)
        end
      end
    end
    it 'should dereference the drawn card from the deck' do
      unique_id = 1
      Room.create!([:id => unique_id])
      get :create, params: {"room_id"=>unique_id}
      room = Room.find(unique_id)
      cards = room.cards.all
      get :draw, params: {:deck_id=>"1", :room_id=>unique_id}, session: {:room_id=>unique_id}
      allow(controller).to receive(:get_room_items).with(cards)
      items = assigns(:room_items)
      draw_card = items[unique_id].first
      deck = Deck.find(1)
      del_card = assigns(:del_card)
      expect(del_card.deck_id).to eq(nil)
    end
    it 'should remove the drawn card from the deck' do

    end
  end
end
