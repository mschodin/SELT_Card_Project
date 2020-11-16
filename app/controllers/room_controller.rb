require 'date'
require 'rubycards'
class RoomController < ApplicationController

  def index

  end

  def new
    @room = Room.create!
    unique_id = @room.id
    session[:room_id] = unique_id

    redirect_to room_path(unique_id.to_i)
  end

  def show
    @room = get_room
    if @room.nil?

    else
      @piles = @room.piles.all
      @room_items = {}
      @room_items = get_room_items(@piles) unless @piles.empty?
    end
  end

  def get_room
    @room = Room.find(session[:room_id])
  end

  def get_room_items(piles)
    piles.each do |pile|
      @cards = pile.cards.all
      @cards.each do |card| #gets all cards loose in the pile
        @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
      end

      @decks = pile.decks.all
      @decks.each do |deck| #gets all cards inside decks in the pile
        @deck_cards = deck.cards.all
        @deck_cards.each do |card|
          @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
        end
      end
    end
    @room_items
  end
end