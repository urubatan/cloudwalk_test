require 'test_helper'

class QuakeLogParserTest < ActiveSupport::TestCase
  test 'identify games' do
    log_parser = QuakeLogParser.new(Rails.root.join('test/assets/four_games.log'))
    log_parser.parse
    assert_equal log_parser.game_list.count, 4
  end
  test 'identify kills in each game' do
    log_parser = QuakeLogParser.new(Rails.root.join('test/assets/game_with_kills.log'))
    @game = nil
    log_parser.parse do |game|
      @game = game
      assert_equal game[:total_kills], 4
      assert_equal game[:kills],
                   [{ time: '1:08', killer: 'Isgalamido', dead: 'Mocinha', how: 'MOD_ROCKET' },
                    { time: '1:26', killer: '<world>', dead: 'Zeh', how: 'MOD_TRIGGER_HURT' },
                    { time: '1:32', killer: '<world>', dead: 'Zeh', how: 'MOD_TRIGGER_HURT' },
                    { time: '1:41', killer: '<world>', dead: 'Dono da Bola', how: 'MOD_FALLING' }]
    end
    assert @game
  end
  test 'identify number of users in each game' do
    log_parser = QuakeLogParser.new(Rails.root.join('test/assets/game_with_kills.log'))
    @game = nil
    log_parser.parse do |game|
      @game = game
      assert_equal game[:players].to_a.sort, ['Dono da Bola', 'Isgalamido', 'Mocinha', 'Zeh']
    end
    assert @game
  end
end
