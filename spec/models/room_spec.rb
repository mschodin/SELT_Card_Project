describe Room do
  it 'should be able to get all decks in room' do
    room = Room.create
    num_decks = 5

    num_decks.times { room.add_deck(room.add_pile) }
    expect(room.decks.all.count).to be(num_decks)
  end

  it 'should be able to add player to room' do
    room = Room.create
    test_name = "Tootsie"
    room.add_player test_name
    expect(room.players.find_by_name(test_name)).to_not be_nil
  end

  it 'should be able to add deck to room' do
    room = Room.create
    pile = room.add_pile
    initial_deck_count = room.decks.count
    room.add_deck(pile)
    expect(room.decks.count).to be(initial_deck_count + 1)
  end

  it 'should be' do
    room = Room.create
    pile = room.add_pile
    deck = room.add_deck(pile)
    expect(room.decks)
  end

  it 'should have a generated code' do
    room = Room.create
    expect(room.code).to_not be_nil
    expect(room.code.length).to eq(4)
  end
end