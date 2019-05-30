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

  def test_it_gets_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach('20122013')
    assert_equal "Jon Cooper", @stat_tracker.winningest_coach('20172018')
  end

  def test_it_gets_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach('20122013')
    assert_equal "Bruce Cassidy", @stat_tracker.worst_coach('20172018')
  end

  def test_most_accurate_team
    assert_equal "Bruins", @stat_tracker.most_accurate_team("20122013")
    assert_equal "Lightning", @stat_tracker.most_accurate_team("20172018")
  end

  def test_least_accurate_team
    assert_equal "Rangers", @stat_tracker.least_accurate_team("20122013")
    assert_equal "Bruins", @stat_tracker.least_accurate_team("20172018")
  end

  def test_most_hits
    assert_equal "Rangers", @stat_tracker.most_hits("20122013")
    assert_equal "Lightning", @stat_tracker.most_hits("20172018")
  end

  def test_fewest_hits
    assert_equal "Bruins", @stat_tracker.fewest_hits("20122013")
    assert_equal "Bruins", @stat_tracker.fewest_hits("20172018")
  end

  def test_power_play_goal_percentage
    assert_equal 0.23, @stat_tracker.power_play_goal_percentage("20122013")
    assert_equal 0.33, @stat_tracker.power_play_goal_percentage("20172018")
  end
end
