class CreateGamehand < ActiveRecord::Migration[5.2]
  def change
    create_table :gamehands do |t|
      t.integer :owner_id
    end
  end
end