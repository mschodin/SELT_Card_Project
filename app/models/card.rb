class Card < ApplicationRecord
  belongs_to :deck, optional: true
  belongs_to :game_hand, optional: true
  belongs_to :pile, optional: true

  def move_to_pile(pile)
    self.update('deck_id': nil, 'game_hand_id': nil, 'pile_id': pile.id)
  end
end
