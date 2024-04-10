require 'test_helper'

class ProcessUploadedLogJobTest < ActiveJob::TestCase
  test 'games without content' do
    uploaded_log = UploadedLog.create(logfile: Rails.root.join('test/fixtures/files/four_games.log').open)
    ProcessUploadedLogJob.perform_now(uploaded_log)
    uploaded_log.reload
    assert_equal uploaded_log.games.count, 4
    uploaded_log.games.each do |game|
      assert_equal game.total_kills, 0
    end
  end
  test 'game with kills' do
    uploaded_log = UploadedLog.create(logfile: Rails.root.join('test/fixtures/files/game_with_kills.log').open)
    ProcessUploadedLogJob.perform_now(uploaded_log)
    uploaded_log.reload
    assert_equal uploaded_log.games.count, 1
    game = uploaded_log.games.first
    assert_equal game.total_kills, 4
    assert_equal game.players.map(&:name), ["Isgalamido", "Zeh", "Dono da Bola"]
    assert_equal game.players.each_with_object({}) { |player,acc| acc[player.name] = player.kill_count  }, { 'Isgalamido' => 1, 'Zeh' => -2, 'Dono da Bola' => -1 }
    assert_equal game.kill_by_means.each_with_object({}) { |kbm,acc| acc[kbm.mean] = kbm.kill_count }, { 'MOD_ROCKET' => 1, 'MOD_TRIGGER_HURT' => 2, 'MOD_FALLING' => 1 }
    assert_equal uploaded_log.player_rankings.map(&:player), ['Isgalamido', 'Dono da Bola', 'Zeh']
  end
end
