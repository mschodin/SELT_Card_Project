require 'rails_helper'

RSpec.describe Card, type: :model do
  before(:each) do
    Room.destroy_all
    Player.destroy_all
    Pile.destroy_all
    @room = Room.create!(:id=>1)
  end
  describe 'moving card to pile' do
    it 'should change foreign key' do
      pile = Pile.create!({:room_id => 1})
      card = Card.create!({:rank=>"Ace", :suit=>"Spades"})

      card.move_to(pile)
      expect(card.deck_id).to be_nil
      expect(card.pile_id).to be(pile.id)
      expect(card.game_hand_id).to be_nil
    end
  end
  describe 'moving card to deck' do
    it 'should change foreign key' do
      pile = Pile.create!({:room_id => 1})
      deck = Deck.create!({:pile_id => pile.id})
      card = Card.create!({:rank=>"Ace", :suit=>"Spades"})

      card.move_to(deck)
      expect(card.deck_id).to be(deck.id)
      expect(card.pile_id).to be_nil
      expect(card.game_hand_id).to be_nil
    end
  end
  describe 'moving card to hand' do
    it 'should change foreign key' do
      player = @room.add_player("TestPlayer")
      card = Card.create!({:rank=>"Ace", :suit=>"Spades"})

      card.move_to(player.game_hand)
      expect(card.deck_id).to be_nil
      expect(card.pile_id).to be_nil
      expect(card.game_hand_id).to be(player.game_hand.id)
    end
  end
end
