require './test/test_helper'

class GameStatisticsTest < Minitest::Test
  def setup
    @game_path = './data/game_dummy.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_gets_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_gets_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_gets_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_it_gets_percentage_home_wins
    assert_equal 0.8, @stat_tracker.percentage_home_wins
  end

  def test_it_gets_percentage_visitor_wins
    assert_equal 0.2, @stat_tracker.percentage_visitor_wins
  end

  def test_it_gets_count_of_games_by_season
    expected = {"20122013" => 4, "20122015" => 1}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_gets_average_goals_per_game
    assert_equal 5.2, @stat_tracker.average_goals_per_game
  end

  def test_it_gets_average_goals_by_season
    expected = {"20122013" => 5.5, "20122015" => 4.0}
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
