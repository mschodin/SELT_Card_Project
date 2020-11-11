require 'date'
require 'rubycards'
include RubyCards

class RoomController < ApplicationController

  def index

  end

  def new
    unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
    Room.create!([:id => unique_id.to_i])
    redirect_to room_path(unique_id.to_i)
  end

  def show
    @deck = RubyCards::Deck.new
    @user1 = GameHand.new()
    @deck.shuffle!
    @user1.draw_card(@deck, 5)

  end

end