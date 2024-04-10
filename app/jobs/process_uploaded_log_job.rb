require 'quake_log_parser'

class ProcessUploadedLogJob < ApplicationJob
  queue_as :default

  def perform(uploaded_log)
    Game.transaction do
      reporter = QuakeConsoleReport.new(ActiveStorage::Blob.service.path_for(uploaded_log.logfile.key))
      report = reporter.generate_report
      report[:player_ranking].each do |player|
        uploaded_log.player_rankings.create player: player
      end
      report.select { |k, _v| k =~ /game_/ }.each_value do |raw_game|
        game = uploaded_log.games.create(raw_game.slice(:total_kills))
        raw_game[:kills].each do |player, kill_count|
          game.players.create name: player, kill_count: kill_count
        end
        raw_game[:kills_by_means].each do |mean, kill_count|
          game.kill_by_means.create(mean: mean, kill_count: kill_count)
        end
      end
    end
  end
end
