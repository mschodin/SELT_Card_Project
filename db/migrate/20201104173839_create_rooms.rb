class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string "code"
    end
    add_index :rooms, :code, unique: true
  end

  def up
    create_table :rooms do |t|
      t.string "code"
    end
    add_index :rooms, :code, unique: true
  end

  def down
    drop_table :rooms
  end
end