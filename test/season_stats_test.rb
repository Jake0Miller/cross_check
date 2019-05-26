require './test/test_helper'

class SeasonStatisticsTest < MiniTest::Test
  def setup
    @game_path = './data/game_tay.csv'
    @team_path = './data/team_tay.csv'
    @game_teams_path = './data/game_team_stats_dummy_iteration_5.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_biggest_bust
    assert_equal "Bruins", @stat_tracker.biggest_bust('20122013')
    assert_equal "Bruins", @stat_tracker.biggest_bust('20172018')
  end

  def test_biggest_surprise
    assert_equal "Rangers", @stat_tracker.biggest_surprise('20122013')
    assert_equal "Lightning", @stat_tracker.biggest_surprise('20172018')
  end

end
