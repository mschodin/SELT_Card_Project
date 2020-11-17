require 'rubycards'

class Deck < ApplicationRecord
  attr_accessor(:card_hash)

  belongs_to :pile
  has_many :cards
  def self.create_deck
    deck = []
    rc_deck = RubyCards::Deck.new
    rc_deck.each { |card| deck << {  :rank => card.rank, :suit => card.suit } }
    deck
  end
  def card_amount
    i = 0
    cards.each do
      i = i + 1
    end
    i
  end

  def draw_card
    @card_hash.pop
  end
  def shuffle_deck
    @card_hash.shuffle
  end
end
