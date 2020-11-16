class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :deck
      t.references :game_hand
      t.references :pile
      t.string :rank
      t.string :suit
      t.timestamps
    end
  end

  def up
    create_table :cards do |t|
      t.references :deck
      t.references :game_hand
      t.references :pile
      t.string :rank
      t.string :suit
      t.timestamps
    end
  end

  def down
    drop_table :cards
  end
end
