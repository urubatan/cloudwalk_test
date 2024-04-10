class CreatePlayerRankings < ActiveRecord::Migration[7.1]
  def change
    create_table :player_rankings do |t|
      t.belongs_to :uploaded_log, null: false, foreign_key: true
      t.string :player

      t.timestamps
    end
  end
end
