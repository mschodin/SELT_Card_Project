require 'date'

class RoomController < ApplicationController

  def index

  end

  def new
    unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
    game = Room.create!(unique_id)
    redirect_to room_path(game)
  end

end