#Alec Cleofe
require 'rubycards'
include RubyCards

class GameHand
  attr_accessor :hand, :name

  def initialize (name)
    @hand = Hand.new
    @name = name
  end

  def deck_shuffle(game_deck)
    game_deck.shuffle!
  end

  #Reminder to Change display implementation
  def display_card

  end


  #Using the draw method in RubyCards::Hand to draw from a specific deck for a specific amount
  def draw_card(game_deck, draw_amt)
    @hand.draw(game_deck, draw_amt)
    hand_correction
  end

  def hand_correction
    holder = []
    @hand.cards.each do |card|
      holder << [card.to_i,card.suit]
    end
    real_symbol(holder)
    @hand = holder
  end

  def real_symbol(handy)
    handy.each do |card|
      if card[1].eql?("Diamonds")
        card[1] = Card::DIAMOND
      elsif card[1].eql?("Clubs")
        card[1] = Card::CLUB
      elsif card[1].eql?("Spades")
        card[1] = Card::SPADE
      elsif card[1].eql?("Hearts")
        card[1] = Card::HEART
      end
    end
  end


end