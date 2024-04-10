class AddPlayersToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :player_names, :string
  end
end
