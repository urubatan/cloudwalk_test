class CreateKillByMeans < ActiveRecord::Migration[7.1]
  def change
    create_table :kill_by_means do |t|
      t.belongs_to :game, null: false, foreign_key: true
      t.string :mean
      t.integer :kill_count

      t.timestamps
    end
  end
end
