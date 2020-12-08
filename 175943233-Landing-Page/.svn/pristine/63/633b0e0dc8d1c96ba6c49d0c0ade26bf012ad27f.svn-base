class CreateDecks < ActiveRecord::Migration[5.2]
  def change
    create_table :decks do |t|
      t.references :pile

      t.timestamps
    end
  end

  def up
    t.references :pile

    t.timestamps
  end

  def down
    drop_table :decks
  end
end
