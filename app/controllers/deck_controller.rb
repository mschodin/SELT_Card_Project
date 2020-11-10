# require 'rubycards'
# include RubyCards

class DeckController < ApplicationController
  def draw
    @room = Room.find(session[:room_id])
    items = @room.cards.all
    @room_items = {}
    @room_items = get_room_items(items) unless items.empty?
    @draw_card = @room_items[params['deck_id'].to_i].first
    deck = Deck.find(params['deck_id'])
    del_card = deck.cards.find_by(suit: @draw_card[:suit], rank: @draw_card[:rank])
    deck.cards.delete(del_card.id)
  end

  def show
  end

  def create
    @room = Room.find(params[:room_id])
    deck_db = @room.decks.create({:room_id => params[:room_id]}) #create instead of build because only attribute is room_id
    @deck = Deck.create_deck
    @deck.shuffle!
    @deck.each do |card|
      deck_db. .create(card)
    end
    redirect_to room_path(params[:room_id])
  end

  def new
  end

  def delete
  end

  def index
  end

  def get_room_items(items)
    items.each do |card|
      @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
    end
    @room_items
  end
end
