require 'rails_helper'
require 'rubycards'
include RubyCards

RSpec.describe Deck, type: :model do
  describe 'getting hand contents' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      Room.create!(:id=>1)
      Player.create!(:name=>"NameTaken", :room_id=>1)
    end
    it 'should return an array of cards in players hand' do
      room = Room.find(1)
      GameHand.create!({:player_id=>1})
      Card.create!({:game_hand_id=>"1", :rank=>"2", :suit=>"S"})
      Card.create!({:game_hand_id=>"1", :rank=>"5", :suit=>"D"})
      Card.create!({:game_hand_id=>"1", :rank=>"7", :suit=>"H"})
      hand = room.game_hands.find(1)
      expect(hand.display_hand_with_id.length).to eq(3)
    end
    it 'should return the correct drawn card to the players hand' do
      room = Room.find(1)
      GameHand.create!({:player_id=>1})
      Card.create!({:game_hand_id=>"1", :rank=>"2", :suit=>"S"})
      hand = room.game_hands.find(1)
      expect(hand.display_hand_with_id).to eq([["2", "S", 1]])
    end
  end
  describe 'shuffle a chosen deck' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      Room.create!(:id=>1)
      Player.create!(:name=>"NameTaken", :room_id=>1)
    end
    it 'should shuffle the order of the deck' do
      room = Room.find(1)
      GameHand.create!({:player_id=>1})
      deck = Deck.create_deck
      deck2 = Deck.create_deck
      hand = room.game_hands.find(1)
      expect(deck).to eq(deck2)
      hand.deck_shuffle(deck)
      expect(deck).to_not eq(deck2)
    end
  end
  describe 'obtain real card symbol for each card' do
    it 'should return a hash of the hand with eh corrected symbols' do
      hand1 = GameHand.new
      deck = RubyCards::Deck.new
      hand1.draw_card(deck, 2)
      expect(hand1.display_cards[0]).to eq([2,RubyCards::Card::CLUB])
      expect(hand1.hand_correction[1]).to eq([2,RubyCards::Card::DIAMOND])
    end
  end
  describe 'draw cards from a Deck' do
    it 'should increase hand size' do
      hand1 = GameHand.new
      deck = RubyCards::Deck.new
      expect(hand1.hand.cards.length).to eq(0)
      hand1.draw_card(deck, 5)
      expect(hand1.hand.cards.length).to eq(5)
      hand1.draw_card(deck, 5)
      expect(hand1.hand.cards.length).to eq(10)
    end
  end
  describe 'get all cards from the hand' do
    it 'should display hand of cards' do
      hand1 = GameHand.new
      deck = RubyCards::Deck.new
      hand1.draw_card(deck, 4)
      expect(hand1.display_hand).to eq([['2',RubyCards::Card::CLUB], ['2',RubyCards::Card::DIAMOND], ['2',RubyCards::Card::HEART], ['2',RubyCards::Card::SPADE]])
    end

  end

end
