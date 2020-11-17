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
    @player1 = @room.players.find(session[:player]['id'])
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
      pile_cards = pile.cards.all
      pile_cards.each do |card| #gets all cards loose in the pile
        @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
      end

      decks = pile.decks.all
      decks.each do |deck| #gets all cards inside decks in the pile
        deck_cards = deck.cards.all
        deck_cards.each do |card|
          @room_items[card['deck_id']].nil? ? @room_items[card['deck_id']] = [{:suit => card['suit'],:rank=> card['rank']}] : @room_items[card['deck_id']] << {:suit => card['suit'],:rank => card['rank']}
        end
      end
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



end