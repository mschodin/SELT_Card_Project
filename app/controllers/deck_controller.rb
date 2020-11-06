# require 'rubycards'
# include RubyCards

class DeckController < ApplicationController
  def draw
  end

  def show
  end

  def create
    @room = Room.find(params[:room_id])
    deck_db = @room.decks.create({:room_id => params[:room_id]}) #create instead of build because only attribute is room_id
    @deck = Deck.create_deck
    @deck.each do |card|
      deck_db.cards.create(card)
    end
    # redirect_to room_path(params[:room_id])
  end

  def new
  end

  def delete
  end

  def index
  end
end
