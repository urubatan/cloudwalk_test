class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.belongs_to :game, null: false, foreign_key: true
      t.string :name
      t.integer :kill_count

      t.timestamps
    end
  end
end
