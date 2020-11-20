class Card < ApplicationRecord
  belongs_to :deck, optional: true
  belongs_to :game_hand, optional: true
  belongs_to :pile, optional: true

  def move_to_pile(pile)
    self.update('deck_id': nil, 'game_hand_id': nil, 'pile_id': pile.id)
  end
  def move_to_deck(deck)
    self.update('deck_id': deck.id, 'game_hand_id': nil, 'pile_id': nil)
  end
  def move_to_hand(player)
    self.update('deck_id': nil, 'game_hand_id': player.game_hand.id, 'pile_id': nil)
  end
end
