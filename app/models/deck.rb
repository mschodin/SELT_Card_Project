require 'rubycards'

class Deck < ApplicationRecord
  attr_accessor(:card_hash)

  belongs_to :pile
  has_many :cards
  def self.create_deck
    deck = []
    rc_deck = RubyCards::Deck.new
    rc_deck.each do |card|
      suit = 'S' if card.suit == 'Spades'
      suit = 'C' if card.suit == 'Clubs'
      suit = 'D' if card.suit == 'Diamonds'
      suit = 'H' if card.suit == 'Hearts'
      rank = card.rank
      rank = 'T' if card.rank == '10'
      rank = 'J' if card.rank == 'Jack'
      rank = 'Q' if card.rank == 'Queen'
      rank = 'K' if card.rank == 'King'
      rank = 'A' if card.rank == 'Ace'
      deck << {  :rank => rank, :suit => suit }
    end
    deck
  end
  def card_amount
    cards.all.length
  end

  def draw_card
    @card_hash.pop
  end
  def shuffle_deck
    @card_hash.shuffle
  end
end
