require 'date'

class RoomController < ApplicationController

  def index

  end

  def new
    unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
    session[:room_id] = unique_id
    @room = Room.create!([:id => unique_id.to_i])
    redirect_to room_path(unique_id.to_i)
  end

  def show
    @room = get_room()
    if @room.nil?

    else
      items = @room.cards.where(params[:id])
      @room_items = {}
      items.each do |card|
        @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
      end
    end
  end

  def get_room
    @room = Room.find(session[:room_id])
  end

end