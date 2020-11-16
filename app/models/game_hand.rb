require 'rubycards'

class GameHand < ApplicationRecord
  belongs_to :player
  has_many :cards

  attr_accessor :hand, :name
  after_initialize :set_hand

  def set_hand
    @hand = RubyCards::Hand.new
  end

  def deck_shuffle(game_deck)
    game_deck.shuffle!
  end

  #Reminder to Change display implementation
  def display_cards
    hand_correction
  end

  def card_amount
    i = 0
    cards.all.each do
      i = i + 1
    end
    i
  end

  def display_hand
    holder = []
    self.cards.all.each do |card|
      holder << [card.rank,card.suit]
    end
    real_symbol(holder)
  end

  #Using the draw method in RubyCards::Hand to draw from a specific deck for a specific amount
  def draw_card(game_deck, draw_amt)
    @hand.draw(game_deck, draw_amt)
  end

  def hand_correction
    holder = []
    @hand.cards.each do |card|
      holder << [card.to_i,card.suit]
    end
    real_symbol(holder)
  end

  def real_symbol(handy)
    handy.each do |card|
      if card[1].eql?("Diamonds")
        card[1] = RubyCards::Card::DIAMOND
      elsif card[1].eql?("Clubs")
        card[1] = RubyCards::Card::CLUB
      elsif card[1].eql?("Spades")
        card[1] = RubyCards::Card::SPADE
      elsif card[1].eql?("Hearts")
        card[1] = RubyCards::Card::HEART
      end
    end
  end


end