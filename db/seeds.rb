# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

room = Room.create
player1 = room.add_player("Tommy")
player2 = room.add_player("Dorothy")
player3 = room.add_player("Sam")
pile = room.add_pile
room.add_deck(pile)