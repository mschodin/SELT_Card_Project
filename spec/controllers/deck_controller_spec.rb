require 'rails_helper'
require 'spec_helper'

describe DeckController do
  describe 'creating deck' do
    it 'routes to create controller' do
      assert_recognizes({controller: 'deck', action: 'create', room_id: "1"}, {path: '/room/1/deck', method: :post})
    end

    it 'should redirect back to main room page' do
      unique_id = 1
      Room.create!([:id => unique_id])
      get :create, params: {"room_id"=>unique_id}
      expect(response).to redirect_to(room_path(unique_id))
    end

    it 'should find a room' do
      unique_id = 1
      testroom = Room.create!([:id => unique_id])
      get :create, params: {:room_id => unique_id}
      expect(assigns(:room)[:id]).to be(unique_id)
    end

    it 'should create a deck' do
      unique_id = 1
      testroom = Room.create!([:id => unique_id])
      deck = RubyCards::Deck.new

      get :create, params: {:room_id => unique_id}
      expect(assigns(:deck).count).to be(deck.count)
    end

    it 'should add 52 cards to db' do
      unique_id = 1
      testroom = Room.create!([:id => unique_id])
      num_cards = Card.all.count
      deck = RubyCards::Deck.new

      get :create, params: {:room_id => unique_id}
      expect(Card.all.count).to be(num_cards + deck.count)
    end
  end
end