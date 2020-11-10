require 'rails_helper'
require 'spec_helper'

describe DeckController do
  describe 'drawing one card' do
    it 'should redirect to drawing view' do
      unique_id = DateTime.now.strftime "%y%m%d%H%M%S"
      Room.create!([:id => unique_id.to_i])
      expect(room_deck_draw_path(:deck_id=>1, :room_id=>unique_id)).to eq('/room/' + unique_id + '/deck/1/draw')
      get :create, params: {"room_id"=>unique_id}
      get :draw, params: {:deck_id=>"1", :room_id=>unique_id}, session: {:room_id=>unique_id}
    end
    it 'should nullify the deck_id of the drawn card' do
      # draw_card = double(:suit => 'Spades', :rank => '2')
      # deck = Deck.new
      # cards = {'deck_id'=>13, :room_id=>"201109132505", :rank=>'2', :suit=>'Spades'}
      # card = double('Card', {'deck_id'=>13, :room_id=>"201109132505", :rank=>'2', :suit=>'Spades'})
      # room = double('Room',:room_id=>"201109132505", :cards=>card)
      #
      # deck = double('Deck')
      #
      # allow(Room).to receive(:find).and_return(room)
      # allow(card).to receive(:where).and_return([cards])
      # allow(Deck).to receive(:find).and_return(deck)
      # allow(deck).to receive(:find_by).and_return([cards])
      # allow(DeckController).to receive(:get_room_items).and_return([])
    end
    it 'should get all of the items in a room as a hash' do

    end
    it 'should remove the drawn card from the deck' do

    end
  end
end
