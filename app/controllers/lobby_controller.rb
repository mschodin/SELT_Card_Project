require 'date'

class LobbyController < ApplicationController

  def index

  end

  def new
    # Create unique id for game
    unique_id = DateTime.now.strftime "%y%m%d%H%M%S"

    # TODO: Create new game
    game = Game.create!(unique_id)

    # TODO: Redirect to new game
    redirect_to game_path(game)
  end

end