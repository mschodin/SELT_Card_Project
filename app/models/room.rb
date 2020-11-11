class Room < ActiveRecord::Base
  has_many :players
  has_many :decks
  has_many :game_hands, through: :players
  has_many :cards, through: :decks

  def add_player name
    player = self.players.create(:name => name)
    player.hand.create
    player
  end
end
