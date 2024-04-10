require 'test_helper'

class QuakeLogParserTest < ActiveSupport::TestCase
  test 'games without content' do
    reporter = QuakeConsoleReport.new(Rails.root.join('test/fixtures/files/four_games.log'))
    report = reporter.generate_report
    assert_equal report, { 'game_1' => { total_kills: 0, players: [], kills: {}, kills_by_means: {} },
                           'game_2' => { total_kills: 0, players: [], kills: {}, kills_by_means: {} },
                           'game_3' => { total_kills: 0, players: [], kills: {}, kills_by_means: {} },
                           'game_4' => { total_kills: 0, players: [], kills: {}, kills_by_means: {} }, :player_ranking => [] }
    assert_equal JSON.pretty_generate(report), reporter.print_report
  end
  test 'game with kills' do
    reporter = QuakeConsoleReport.new(Rails.root.join('test/fixtures/files/game_with_kills.log'))
    report = reporter.generate_report
    assert_equal report, { 'game_1' => { total_kills: 4, players: ['Isgalamido', 'Mocinha', 'Zeh', 'Dono da Bola'],
                                         kills: { 'Isgalamido' => 1, 'Zeh' => -2, 'Dono da Bola' => -1 },
                                         kills_by_means: { 'MOD_ROCKET' => 1, 'MOD_TRIGGER_HURT' => 2, 'MOD_FALLING' => 1 } },
                           :player_ranking => ['Isgalamido', 'Dono da Bola', 'Zeh'] }
    assert_equal JSON.pretty_generate(report), reporter.print_report
  end
end
