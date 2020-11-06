require 'rubycards'

class Deck < ApplicationRecord
  has_many :cards
  def self.create_deck
    deck = []
    rc_deck = RubyCards::Deck.new
    rc_deck.each { |card| deck << {  :rank => card.rank, :suit => card.suit } }
    deck
  end
end
