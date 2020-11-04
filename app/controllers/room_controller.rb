require 'date'

class RoomController < ApplicationController

  def index

  end

  def new
    unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
    Room.create!([:id => unique_id.to_i])
    redirect_to room_path(unique_id.to_i)
  end

  def show

  end

end