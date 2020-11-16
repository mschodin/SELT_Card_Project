class CreatePiles < ActiveRecord::Migration[5.2]
  def change
    create_table :piles do |t|
      t.references :room
      t.timestamps
    end
  end

  def up
    create_table :piles do |t|
      t.references :room
      t.timestamps
    end
  end

  def down
    drop_table :piles
  end
end
