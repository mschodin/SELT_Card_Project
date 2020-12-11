# require 'rubycards'
# include RubyCards

class DeckController < ApplicationController
  def draw
    @room = Room.find(session[:room_id])
    items = @room.cards.all
    @room_items = {}
    @room_items = get_room_items(items) unless items.empty?
    @draw_card = @room_items[params['deck_id'].to_i].first
    deck = @room.decks.find(params['deck_id'])
    @del_card = deck.cards.find_by(suit: @draw_card[:suit], rank: @draw_card[:rank])
    #TODO: add cards to player hand
    #player = @room.players.find(session[:player_id])
    #placeholder for single person display
    @player1 = @room.players.find(session[:player]['id'])
    @del_card.update('deck_id': nil, 'game_hand_id': @player1.game_hand.id)#, 'gamehand_id': player.game_hand.id)
    ActionCable.server.broadcast 'activity_channel' , update: "<script> location.reload() </script>"

  end

  def show
  end

  def create
    @room = Room.find(params[:room_id])
    pile = Pile.find(params[:pile_id])
    @deck = @room.add_deck(pile)
    ActionCable.server.broadcast 'activity_channel' , update: "<script> location.reload() </script>"
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
