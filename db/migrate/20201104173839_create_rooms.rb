class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|

    end
  end

  def up
    create_table :rooms do |t|

    end
  end

  def down
    drop_table :rooms
  end
end