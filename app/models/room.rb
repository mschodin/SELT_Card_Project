class Room < ActiveRecord::Base
  has_many :players
  has_many :piles
  has_many :decks, through: :piles
  has_many :game_hands, through: :players
  has_many :cards, through: :decks

  before_create do # generates room code if not given
    code = SecureRandom.alphanumeric(4)
    while Room.exists?(code: code)
      code = SecureRandom.alphanumeric(4)
    end
    self.code = code if self.code.blank?
  end

  def add_player name
    player = self.players.create(:name => name)
    player.create_game_hand
    player
  end

  def add_pile
    pile = self.piles.create #create new pile
    pile
  end

  def add_deck(pile)
    deck_db = pile.decks.create #create instead of build because only attribute is room_id
    deck = Deck.create_deck
    deck.map { |card| card[:game_hand_id] = nil }
    deck.shuffle!
    added_cards = deck_db.cards.create(deck)
    deck
  end

  def get_piles_and_cards
    all_piles = []
    self.piles.all.each do |pile|
      cards_arr = []
      pile.cards.all.each do |card|
        cards_arr << [card.rank, card.suit, card.id]
      end
      pile.decks.all.each do |deck|
        deck.cards.all.each do |card|
          cards_arr << [card.rank, card.suit, card.id]
        end
      end
      all_piles << [pile.id, cards_arr]
    end
    all_piles
  end

end