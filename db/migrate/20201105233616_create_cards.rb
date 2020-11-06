class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :game_deck

      t.timestamps
    end
  end
end
