class Card < ApplicationRecord
  belongs_to :deck, optional: true
  belongs_to :game_hand, optional: true
end
