# frozen_string_literal: true
require 'set'

# Log parser for Quake log files
# It'll infer events and kills, but won't check all the log entries
# this log reader is implemented using streaming so that it won't use too much memory if a huge log file is uploaded
class QuakeLogParser
  attr_accessor :game_list

  def initialize(file_name)
    @file_name = file_name
    @game_list = []
    @current_game = nil
  end

  def parse
    parse_events do |time, event, data|
      case event
      when 'InitGame'
        unless @current_game.nil?
          @current_game[:end_time] = time
          if block_given?
            yield(@current_game)
          else
            @game_list << @current_game
          end
        end
        @current_game = {
          start_time: time,
          end_time: '',
          total_kills: 0,
          players: Set.new,
          kills: []
        }
      when 'ShutdownGame'
        @current_game[:end_time] = time
        if block_given?
          yield(@current_game)
        else
          @game_list << @current_game
        end
        @current_game = nil
      when 'Kill'
        @current_game[:total_kills] += 1
        kill_data = data.split(':').last
        killer, dead, how = kill_data.split(/(killed|by)/).values_at(0, 2, 4).map(&:strip)
        kill = {
          time: time,
          killer: killer,
          dead: dead,
          how: how
        }
        @current_game[:players] << killer unless killer == '<world>'
        @current_game[:players] << dead
        @current_game[:kills] << kill
      end
    end
    self
  end

  private

  def parse_events
    File.foreach(@file_name) do |line|
      next if line.index('------------------------------------------------------------')

      time = line[0..6].strip
      event = line[6..line[6..].index(':') + 5].strip
      data = line[(line[6..].index(':') + 7)..].strip
      yield(time, event, data, line)
    end
  end
end
