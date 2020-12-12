require 'rails_helper'
require 'spec_helper'

describe RoomController do
  describe 'creating a room' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      @unique_id = "1"
    end
    it 'should create a new room when new room controller path is called' do
      room = assigns(:room)
      expect(Room).to receive(:create!)
      allow(room).to receive(:id).and_return(@unique_id)
      allow(room).to receive(:add_player)
      post :create, :params => {:name => "John"}
    end
    it 'should redirect to the newly created room when a new room is requested' do
      expect(room_path(@unique_id)).to eq('/room/' + @unique_id)
      post :join, :params => { :name => "John", :room_id => "9999999999"}
    end
    it 'should not allow creating a room with an invalid name' do
      expect(Room).to_not receive(:create!)
      post :create, :params => {:name => "John!@%!@"}
    end
    it 'should not allow creating a room with an empty name' do
      expect(Room).to_not receive(:create!)
      post :create, :params => {:name => ""}
    end
  end
  describe 'showing a room and its contents' do
    before(:each) do
      Room.destroy_all
      Player.destroy_all
      Pile.destroy_all
      room = Room.create!(:id=>1)
      room.add_player("TestPlayer")
    end
    it 'should get all of the room items as a hash' do
      # post :create, :params => {:name => "John"}
      get :show, params: {:id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      allow(controller).to receive(:get_room)

      room = assigns(:room)
      pile = room.piles.create({:room_id=>1})
      deck_db = pile.decks.create({:pile_id=>1})
      deck = Deck.create_deck
      deck.shuffle!
      deck.each do |card|
        deck_db.cards.create(card)
      end
      cards = assigns(:items)

      items = controller.get_room_items(room.piles.all)
      items.each do |key,deck|
        expect(deck).to be_a(Array)
        deck.each do |cards|
          expect(cards).to be_a(Hash)
        end
      end
    end
    it 'should get all player names and card amounts' do
      room = Room.find(1)
      room.add_player("Tony")
      room.add_player("Alyssa")
      pile = room.piles.create({:room_id=>1})
      deck_db = pile.decks.create({:pile_id=>1})
      deck = Deck.create_deck
      deck.shuffle!
      deck.each do |card|
        deck_db.cards.create(card)
      end
      player_info = {}
      player_hash = {"Alyssa"=>0, "TestPlayer"=>0, "Tony"=>0}
      room.players.ids.each do |player_id|
        name = room.players.find(player_id).name
        player_info[name] = room.game_hands.find(player_id).card_amount
      end
      expect(player_hash).to eq(player_info)
    end
    it 'gets all piles in room' do
      room = Room.find(1)
      room.piles.create({:room_id=>1})
      room.piles.create({:room_id=>1})
      expect(room.get_piles_and_cards.length).to eq(2)
    end
    it 'gets all piles and contents' do
      room = Room.find(1)
      pile = room.piles.create({:room_id=>1})
      deck_db = pile.decks.create({:pile_id=>1})
      deck = Deck.create_deck
      deck.shuffle!
      deck.each do |card|
        deck_db.cards.create(card)
      end
      expect(room.get_piles_and_cards[0][1].length).to eq(52)
    end
    it 'gets piles with card arrays organized' do
      room = Room.find(1)
      pile = room.piles.create({:room_id=>1})
      deck_db = pile.decks.create({:pile_id=>1})
      deck_db.cards.create({:rank=>"2", :suit=>"C"})
      piles_arr = [[1, [["2", "C", 1]]]]
      expect(room.get_piles_and_cards).to eq(piles_arr)
    end
    it 'gets cards from piles without decks' do
      room = Room.find(1)
      pile = room.piles.create({:room_id=>1})
      pile.cards.create({:rank=>"2", :suit=>"C"})
      piles_arr = [[1, [["2", "C", 1]]]]
      expect(room.get_piles_and_cards).to eq(piles_arr)
    end
  end
  describe 'join a room' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      Room.create!(:id=>1, :code=>"TEST")
      Player.create!(:name=>"NameTaken", :room_id=>1)
    end
    it 'joins room with valid id' do
      post :join, :params => { :name => "John", :room_id => "1", :room_code => "TEST"}
      expect(response).to redirect_to(room_path(1))
    end
    it 'prevents join when invalid name is given' do
      post :join, :params => { :name => "John#^#&", :room_id => "1", :room_code => "TEST"}
      expect(response).to_not redirect_to(room_path(1))
      post :join, :params => { :name => "", :room_id => "1", :room_code => "TEST"}
      expect(response).to_not redirect_to(room_path(1))
    end
    it 'prevents join when invalid room id is given' do
      post :join, :params => { :name => "John", :room_id => "roomid", :room_code => "TEST"}
      expect(response).to_not redirect_to(room_path(1))
      post :join, :params => { :name => "John", :room_id => ""}
      expect(response).to_not redirect_to(room_path(1))
    end
    it 'prevents join when invalid room code is given' do
      post :join, :params => { :name => "John", :room_id => "1", :room_code => ""}
      expect(response).to_not redirect_to(room_path(1))
      post :join, :params => { :name => "John", :room_id => "1", :room_code => "INCORRECT"}
      expect(response).to_not redirect_to(room_path(1))
    end
    it 'prevents join when room id given does not exist' do
      post :join, :params => { :name => "John", :room_id => "9999999999", :room_code => "TEST"}
      expect(response).to_not redirect_to(room_path(1))
    end
    it 'prevents joining a room when selected player name is already in that given room' do
      post :join, :params => { :name => "NameTaken", :room_id => "1", :room_code => "TEST"}
      expect(response).to_not redirect_to(room_path(1))
    end
  end
  describe 'leave a room' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      GameHand.destroy_all
      room = Room.create!(:id=>1)
      room.add_player("TestPlayer")
    end
    it 'destroys player model when a player leaves' do
      get :leave, params: {:action=>"leave", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(Player.exists?(1)).to be_falsy
    end
    it 'redirects to the landing page when a player leaves' do
      get :leave, params: {:action=>"leave", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(response).to redirect_to(room_index_path)
    end
    it 'dumps cards in an empty pile if there is one' do
      room = Room.find(1)
      pile = room.piles.create({:room_id=>1}) # empty pile
      Card.create!(:game_hand_id=>"1")
      get :leave, params: {:action=>"leave", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(pile.cards.empty?).to be_falsey
    end
    it 'dumps cards in a new pile if there are no empty piles' do
      room = Room.find(1)
      pile = room.piles.create({:room_id=>1}) # empty pile
      Card.create!(:pile_id=>"1")
      Card.create!(:game_hand_id=>"1")
      get :leave, params: {:action=>"leave", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(pile.cards.count).to equal(1)
      expect(room.piles.count).to equal(2)
      expect(Pile.find(2).cards.count).to equal(1)
    end
  end
  describe 'draw multiple cards' do
    before(:each) do
      Room.destroy_all
      Player.destroy_all
      Pile.destroy_all
      GameHand.destroy_all
      Deck.destroy_all
      @room = Room.create!(:id=>1)
      @room.add_player("TestPlayer")
      @hand = GameHand.create!({:player_id=>1})
      pile = Pile.create!({:room_id => 1})
      @room.add_deck(pile)
    end
    it 'should move the requested number of cards to the player hand' do
      post :draw_multiple, :params => {:count => "5", :room_id => "1", :pile_id => "1", :hand_id => @hand.id}
      expect(@hand.display_hand_with_id.length).to eq(5)
    end
  end
  describe 'end a game' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      Room.create!(:id=>1)
      Player.create!(:id=>"1", :name=>"John", :room_id=>"1")
    end
    it 'should destroy the room when the game is ended' do
      get :destroy, params: {:action=>"destroy", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(Room.exists?(1)).to be_falsy
    end
    it 'should redirects to the landing page when the game is ended' do
      get :destroy, params: {:action=>"destroy", :controller=>"room", :room_id=>"1"}, session: {:room_id=>"1", :player=>Player.find(1)}
      expect(response).to redirect_to(room_index_path)
    end
  end
  describe 'moving cards' do
    before(:each) do
      Room.destroy_all
      Pile.destroy_all
      Player.destroy_all
      room = Room.create!(:id=>1)
      room.add_player("TestPlayer")
    end
    it 'should move the card to a deck if a deck_id is given' do
      hand = Player.find(1).game_hand
      card = Card.create!(:game_hand_id=>hand.id)
      deck = Room.find(1).piles.create!(:room_id=>"1").decks.create!(:pile_id=>"1")
      post :move_card, :params => {:room_id => "1", :card_id => card.id, :deck_id => deck.id}
      expect(deck.cards.count).to equal(1)
      expect(hand.cards.count).to equal(0)
    end
    it 'should move the card to a pile if a pile_id is given' do
      hand = Player.find(1).game_hand
      card = Card.create!(:game_hand_id=>hand.id)
      pile = Room.find(1).piles.create!(:room_id=>"1")
      post :move_card, :params => {:room_id => "1", :card_id => card.id, :pile_id => pile.id}
      expect(pile.cards.count).to equal(1)
      expect(hand.cards.count).to equal(0)
    end
    it 'should move the card to a hand if a hand_id is given' do
      hand = Player.find(1).game_hand
      pile = Room.find(1).piles.create!(:room_id=>"1")
      card = Card.create!(:pile_id=>pile.id)
      post :move_card, :params => {:room_id => "1", :card_id => card.id, :hand_id => hand.id}
      expect(hand.cards.count).to equal(1)
      expect(pile.cards.count).to equal(0)
    end
  end
end
