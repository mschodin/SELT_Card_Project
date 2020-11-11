require 'date'
require 'rubycards'
include RubyCards

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
      @items = @room.cards.all
      @room_items = {}
      @room_items = get_room_items(@items) unless @items.empty?
    end
  end

  def get_room
    @room = Room.find(session[:room_id])
  end

  def get_room_items(items)
    items.each do |card|
      @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
    end
    @room_items
  end
end