class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.references :room

      t.timestamps
    end
  end

  def up
    create_table :players do |t|
      t.string :name
      t.references :room

      t.timestamps
    end
  end

  def down
    drop_table :players
  end
end
