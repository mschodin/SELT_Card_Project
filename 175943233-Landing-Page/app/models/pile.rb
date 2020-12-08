require 'rubycards'

class Pile < ApplicationRecord
  belongs_to :room
  has_many :cards
  has_many :decks

  #attr_accessor(:deck_hash)
end
