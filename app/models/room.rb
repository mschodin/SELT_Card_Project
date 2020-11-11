class Room < ActiveRecord::Base
  has_many :players
  has_many :decks
  has_many :cards, through: :decks
end