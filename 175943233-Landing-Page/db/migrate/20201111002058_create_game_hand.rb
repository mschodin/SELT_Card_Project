class CreateGameHand < ActiveRecord::Migration[5.2]
  def change
    create_table :game_hands do |t|
      t.references :player
    end
  end

  def up
    create_table :game_hands do |t|
      t.references :player
    end
  end

  def down
    drop_table :game_hands
  end
end
