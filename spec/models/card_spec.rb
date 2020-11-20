require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'moving card to pile' do
    it 'should change foreign key' do
      pile = Pile.create!({:room_id => 1})
      card = Card.create!({:rank=>"Ace", :suit=>"Spades"})

      card.move_to_pile(pile)
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

      card.move_to_deck(deck)
      expect(card.deck_id).to be(deck.id)
      expect(card.pile_id).to be_nil
      expect(card.game_hand_id).to be_nil
    end
  end
  describe 'moving card to hand' do
    it 'should change foreign key' do
      Player.destroy_all
      player = Player.create!({:id=> 1, :room_id=> 1, :name=> "UniqueName"})
      GameHand.create!({:player_id=>1})
      card = Card.create!({:rank=>"Ace", :suit=>"Spades"})

      card.move_to_hand(player)
      expect(card.deck_id).to be_nil
      expect(card.pile_id).to be_nil
      expect(card.game_hand_id).to be(player.game_hand.id)
    end
  end
end
