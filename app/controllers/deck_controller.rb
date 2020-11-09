# require 'rubycards'
# include RubyCards

class DeckController < ApplicationController
  def draw
    @room = Room.find(session[:room_id])
    items = @room.cards.where(session[:room_id])
    @room_items = {}
    items.each do |card|
      @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
    end
    @draw_card = @room_items[params['deck_id'].to_i].pop
    deck = Deck.find(params['deck_id'])
    deck.cards.find_by(suit: @draw_card[:suit], rank: @draw_card[:rank]).update(deck_id: nil)
  end

  def show
  end

  def create
    @room = Room.find(params[:room_id])
    deck_db = @room.decks.create({:room_id => params[:room_id]}) #create instead of build because only attribute is room_id
    @deck = Deck.create_deck
    @deck.shuffle!
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
