require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe 'creating deck' do
    it 'should return a array of hashes' do
      deck = Deck.create_deck
      expect(deck).to be_a(Array)
      expect(deck).to all(be_a(Hash))
    end

    it 'should return 52 cards' do
      deck = Deck.create_deck
      expect(deck.count).to be(52)
    end

    it 'should return an array of cards (with rank and suit)' do
      deck = Deck.create_deck
      expect(deck).to all(have_key(:rank))
      expect(deck).to all(have_key(:suit))
    end
  end
end
