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
    it 'gets the correct card amount' do
      room = Room.find(1)
      GameHand.create!({:player_id=>1})
      Card.create!({:game_hand_id=>"1", :rank=>"2", :suit=>"S"})
      Card.create!({:game_hand_id=>"1", :rank=>"5", :suit=>"D"})
      Card.create!({:game_hand_id=>"1", :rank=>"7", :suit=>"H"})
      hand = room.game_hands.find(1)
      expect(hand.card_amount).to eq(3)
    end
    it 'returns the correct diamonds symbol' do
      card = Card.create!(:rank=>"6", :suit=>"Diamonds")
      card_arr = [[card.rank, card.suit]]
      hand = GameHand.create!({:player_id=>1})
      hand.real_symbol(card_arr)
      expect(card_arr[0][1]).to eq(RubyCards::Card::DIAMOND)
    end
    it 'returns the correct spades symbol' do
      card = Card.create!(:rank=>"6", :suit=>"Spades")
      card_arr = [[card.rank, card.suit]]
      hand = GameHand.create!({:player_id=>1})
      hand.real_symbol(card_arr)
      expect(card_arr[0][1]).to eq(RubyCards::Card::SPADE)
    end
    it 'returns the correct clubs symbol' do
      card = Card.create!(:rank=>"6", :suit=>"Clubs")
      card_arr = [[card.rank, card.suit]]
      hand = GameHand.create!({:player_id=>1})
      hand.real_symbol(card_arr)
      expect(card_arr[0][1]).to eq(RubyCards::Card::CLUB)
    end
    it 'returns the correct hearts symbol' do
      card = Card.create!(:rank=>"6", :suit=>"Hearts")
      card_arr = [[card.rank, card.suit]]
      hand = GameHand.create!({:player_id=>1})
      hand.real_symbol(card_arr)
      expect(card_arr[0][1]).to eq(RubyCards::Card::HEART)
    end
  end
end
