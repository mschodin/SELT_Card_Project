class Card < ApplicationRecord
  belongs_to :deck, optional: true
  belongs_to :game_hand, optional: true
  belongs_to :pile, optional: true

  def move_to(container)
    case container
      when Deck then self.update('deck_id': container.id, 'game_hand_id': nil, 'pile_id': nil)
      when Pile then self.update('deck_id': nil, 'game_hand_id': nil, 'pile_id': container.id)
      when GameHand then self.update('deck_id': nil, 'game_hand_id': container.id, 'pile_id': nil)
    end
  end
end
