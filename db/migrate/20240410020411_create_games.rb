class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.belongs_to :uploaded_log, null: false, foreign_key: true
      t.integer :total_kills

      t.timestamps
    end
  end
end
