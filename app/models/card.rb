class Card < ApplicationRecord
  belongs_to :deck
  belongs_to :game_hand
end
