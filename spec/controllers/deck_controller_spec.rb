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
      Room.create!
      unique_id = Room.last.id.to_s
      deck = RubyCards::Deck.new
      get :create, params: {"room_id"=>unique_id}
      expect(assigns(:deck).count).to be(deck.count)
    end
    it 'return the room items as a hash' do
      Room.create!
      unique_id = Room.last.id.to_s
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
      Room.create!
      unique_id = Room.last.id
      get :create, params: {"room_id"=>unique_id}
      room = Room.find(unique_id)
      cards = room.cards.all
      get :draw, params: {:deck_id=>"1", :room_id=>unique_id}, session: {:room_id=>unique_id}
      allow(controller).to receive(:get_room_items).with(cards)
      items = assigns(:room_items)
      draw_card = items[1].first
      del_card = assigns(:del_card)
      expect(del_card[:suit]).to eq(draw_card[:suit])
      expect(del_card[:rank]).to eq(draw_card[:rank])
      expect(del_card.deck_id).to eq(nil)
    end
  end

  describe 'creating deck' do
    it 'routes to create controller' do
      assert_recognizes({controller: 'deck', action: 'create', room_id: "1"}, {path: '/room/1/deck', method: :post})
    end

    it 'should redirect back to main room page' do
      Room.create!
      unique_id = Room.last.id.to_s
      get :create, params: {"room_id"=>unique_id}
      expect(response).to redirect_to(room_path(unique_id))
    end

    it 'should find a room' do
      testroom = Room.create!
      unique_id = Room.last.id
      get :create, params: {:room_id => unique_id}
      expect(assigns(:room)[:id]).to be(unique_id)
    end

    it 'should create a deck' do
      testroom = Room.create!
      unique_id = Room.last.id.to_s
      deck = RubyCards::Deck.new

      get :create, params: {:room_id => unique_id}
      expect(assigns(:deck).count).to be(deck.count)
    end

    it 'should add 52 cards to db' do
      testroom = Room.create!
      unique_id = Room.last.id.to_s
      num_cards = Card.all.count
      deck = RubyCards::Deck.new

      get :create, params: {:room_id => unique_id}
      expect(Card.all.count).to be(num_cards + deck.count)
    end
  end
end
