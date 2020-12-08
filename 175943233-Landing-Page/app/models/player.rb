class Player < ApplicationRecord
  belongs_to :room
  has_one :game_hand
  has_many :cards, through: :game_hand
end
