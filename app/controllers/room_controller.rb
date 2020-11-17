require 'date'
require 'rubycards'
class RoomController < ApplicationController

  def index

  end

  def create
    if /\W/ =~ params[:name] || params[:name].length.eql?(0)
      redirect_to room_index_path, notice: "Name is invalid, please try again"
    else
      @room = Room.create!
      unique_id = @room.id
      session[:room_id] = unique_id
      session[:player] = @room.add_player(params[:name])
      redirect_to room_path(unique_id.to_i)
    end
  end

  def show
    @room = get_room
    @name = session[:player]['name']
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

  def join
    if /\W/ =~ params[:name] || params[:name].length.eql?(0)
      redirect_to room_index_path, notice: "Name is invalid, please try again"
    elsif /\D/ =~ params[:room_id] || params[:room_id].length.eql?(0)
      redirect_to room_index_path, notice: "Room id invalid, please try again"
    elsif Player.exists?(room_id: params[:room_id], name: params[:name])
      redirect_to room_index_path, notice: "Player with name " + params[:name] + " already exists in room " + params[:room_id]
    elsif Room.exists?(id: params[:room_id])
      session[:room_id] = params[:room_id]
      room = get_room
      session[:player] = room.add_player(params[:name])
      redirect_to(room_path(params[:room_id]))
    else
      redirect_to room_index_path, notice: "Room does not exist, please try again"
    end
  end

  def leave
    session[:room_id] = nil
    session[:player] = nil
  end


end