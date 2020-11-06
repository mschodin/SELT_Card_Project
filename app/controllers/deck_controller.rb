# require 'rubycards'
# include RubyCards

class DeckController < ApplicationController
  def draw
  end

  def show
  end

  def create
    @decks ||= []
    @decks << Deck.create_deck
    # redirect_to room_path(params[:room_id])
  end

  def new
  end

  def delete
  end

  def index
  end
end
