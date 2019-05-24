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
    # skip
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_it_gets_biggest_blowout
    # skip
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_it_gets_percentage_home_wins
    # skip
    assert_equal 80.00, @stat_tracker.percentage_home_wins
  end

  def test_it_gets_percentage_home_wins
    # skip
    assert_equal 20.00, @stat_tracker.percentage_away_wins
  end

  def test_it_gets_count_of_games_by_season
    expected = {
      "20122013" => 5
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_gets_average_goals_per_game

    assert_equal 5.2, @stat_tracker.average_goals_per_game
  end

  def test_it_gets_average_goals_by_season
    expected = {
      "20122013"=>5.2
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
end
