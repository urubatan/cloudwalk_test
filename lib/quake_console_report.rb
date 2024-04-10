require 'quake_log_parser'
require 'json'

class QuakeConsoleReport
  def initialize(file_name)
    @log_parser = QuakeLogParser.new(file_name)
  end

  def generate_report
    report = {}
    @log_parser.parse do |raw_game|
      name = "game_#{report.count + 1}"
      game = {
        total_kills: raw_game[:total_kills],
        players: raw_game[:players].to_a,
        kills: Hash.new(0),
        kills_by_means: Hash.new(0)
      }
      raw_game[:kills].each do |hash_kill|
        game[:kills_by_means][hash_kill[:how]] += 1
        if hash_kill[:killer] == '<world>'
          game[:kills][hash_kill[:dead]] -= 1
        else
          game[:kills][hash_kill[:killer]] += 1
        end
      end
      report[name] = game
    end
    ranking = Hash.new(0)
    report.values.each do |game|
      game[:kills].each do |player, kill_count|
        ranking[player] += kill_count
      end
    end
    report[:player_ranking] = ranking.sort_by { |_key, value| -value }.map(&:first)
    report
  end

  def print_report
    report = generate_report
    JSON.pretty_generate(report)
  end
end
