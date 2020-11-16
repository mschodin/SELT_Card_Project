class PileController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @pile = @room.add_pile
    redirect_to room_path(params[:room_id])
  end

  def delete
  end
end
