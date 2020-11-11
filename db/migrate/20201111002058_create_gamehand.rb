class CreateGamehand < ActiveRecord::Migration[5.2]
  def change
    create_table :gamehands do |t|
      t.references :player
    end
  end

  def up
    create_table :gamehands do |t|
      t.references :player
    end
  end

  def down
    drop_table :gamehands
  end
end
