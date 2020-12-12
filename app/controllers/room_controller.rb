require 'date'
require 'rubycards'

class RoomController < ApplicationController
  respond_to :json, :js, :html
  skip_before_action :verify_authenticity_token

  def index
    session[:room_id] = nil
    session[:player] = nil
    flash.keep(:notice)
    # render component: 'Home', props: {}, class: 'Home'
  end

  def create
    flash.discard
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
    if Room.exists?(session[:room_id])
      @room = get_room
      @name = session[:player]['name']
      @player1 = @room.players.find(session[:player]['id'])
      @player_info = {}
      @room.players.ids.each do |player_id|
        name = @room.players.find(player_id).name
        @player_info[name] = @room.game_hands.find(player_id).card_amount
      end
      if @room.nil?

      else
        @piles = @room.piles.all
        @room_items = {}
        @room_items = get_room_items(@piles) unless @piles.empty?
      end

      8.times { @room.add_pile } if @piles.empty?
      @piles_to_deck = {}
      @piles.each { |pile| @piles_to_deck[pile.id] = pile.decks.pluck("id")}
    else
      redirect_to room_index_path
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
    flash.discard
    if /\W/ =~ params[:name] || params[:name].length.eql?(0)
      redirect_to room_index_path, notice: "Name is invalid, please try again"
    elsif /\D/ =~ params[:room_id] || params[:room_id].length.eql?(0)
      redirect_to room_index_path, notice: "Room id invalid, please try again"
    elsif Player.exists?(room_id: params[:room_id], name: params[:name])
      redirect_to room_index_path, notice: "Player with name " + params[:name] + " already exists in room " + params[:room_id]
    elsif Room.exists?(id: params[:room_id])
      if Room.exists?(id: params[:room_id], code: params[:room_code])
        session[:room_id] = params[:room_id]
        room = get_room
        session[:player] = room.add_player(params[:name])
        redirect_to(room_path(params[:room_id]))
      else
        redirect_to room_index_path, notice: "Room code invalid, please try again"
      end
    else
      redirect_to room_index_path, notice: "Room does not exist, please try again"
    end
    ActionCable.server.broadcast "activity_channel_#{session[:room_id]}" , update: "<script> location.reload() </script>"
  end

  def leave
    room = get_room
    dump_pile = ''
    room.piles.each do |pile| # Check if there are any empty piles
      if pile.decks.empty? && pile.cards.empty? then dump_pile = pile end
    end
    if dump_pile.blank? then dump_pile = room.add_pile end # if there's no empty piles make a new pile
    Player.find(session[:player]["id"]).cards.each do |card| # dump player cards in the pile
      card.move_to(dump_pile)
    end

    Player.find(session[:player]["id"]).destroy
    session[:room_id] = nil
    session[:player] = nil
    ActionCable.server.broadcast "activity_channel_#{session[:room_id]}" , update: "<script> location.reload() </script>"
    redirect_to room_index_path, notice: "Thank you for playing!"
  end

  def move_card
    card = Card.find(params[:card_id])
    if params.has_key?(:deck_id) then card.move_to(Deck.find(params[:deck_id]))
    elsif params.has_key?(:pile_id) then card.move_to(Pile.find(params[:pile_id]))
    elsif params.has_key?(:hand_id) then card.move_to(GameHand.find(params[:hand_id]))
    end
    ActionCable.server.broadcast "activity_channel_#{session[:room_id]}" , update: "<script> location.reload() </script>"
  end

  def draw_multiple
    pileId = params[:pile_id]
    pileId.slice! "pile"
    room = Room.find(params[:room_id])
    all_piles = room.get_piles_and_cards
    pile = nil
    all_piles.each do |piles|
      pile = piles if piles[0].to_s == pileId
    end
    counter = 0
    params[:count].to_i.times do
      card = Card.find(pile[1][counter][2])
      card.move_to(GameHand.find(params[:hand_id]))
      counter += 1
    end
    ActionCable.server.broadcast "activity_channel_#{session[:room_id]}" , update: "<script> location.reload() </script>"
  end

  def destroy
    redirect_to room_index_path
    Room.find(session[:player]['room_id']).destroy
    ActionCable.server.broadcast "activity_channel_#{session[:room_id]}" , update: "<script> location.reload() </script>"
  end

end