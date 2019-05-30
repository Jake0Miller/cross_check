require './test/test_helper'

class LeagueHelperTest < Minitest::Test
  def setup
    @game_path = './data/game_jake.csv'
    @team_path = './data/team_jake.csv'
    @game_teams_path = './data/game_teams_stats_dummy.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_total_goals_and_games
    assert_equal 21, @stat_tracker.total_goals_and_games["6".to_sym][0]
    assert_equal 7, @stat_tracker.total_goals_and_games["6".to_sym][1]
    assert_equal 15, @stat_tracker.total_goals_and_games["3".to_sym][0]
    assert_equal 7, @stat_tracker.total_goals_and_games["3".to_sym][1]
    assert_equal 12, @stat_tracker.total_goals_and_games["15".to_sym][0]
    assert_equal 4, @stat_tracker.total_goals_and_games["15".to_sym][1]
  end

  def test_average_score
    assert_equal 3.0, @stat_tracker.average_score["6".to_sym]
    assert_equal 2.14, @stat_tracker.average_score["3".to_sym]
    assert_equal 3.0, @stat_tracker.average_score["15".to_sym]
  end

  def test_total_goals_allowed_and_games
    assert_equal 11, @stat_tracker.total_goals_allowed_and_games["6".to_sym][0]
    assert_equal 22, @stat_tracker.total_goals_allowed_and_games["3".to_sym][0]
    assert_equal 8, @stat_tracker.total_goals_allowed_and_games["15".to_sym][0]
  end

  def test_average_goals_allowed
    assert_equal 1.57, @stat_tracker.average_goals_allowed["6".to_sym]
    assert_equal 3.14, @stat_tracker.average_goals_allowed["3".to_sym]
    assert_equal 2.0, @stat_tracker.average_goals_allowed["15".to_sym]
  end

  def test_total_wins_and_games
    expected = {home: [4,4], away: [2,3]}
    assert_equal expected, @stat_tracker.total_wins_and_games["6".to_sym]
    expected = {home: [2,3], away: [0,4]}
    assert_equal expected, @stat_tracker.total_wins_and_games["3".to_sym]
    expected = {home: [1,2], away: [1,2]}
    assert_equal expected, @stat_tracker.total_wins_and_games["15".to_sym]
  end

  def test_home_win_and_away_win
    assert @stat_tracker.home_win?(@stat_tracker.games.first)
    refute @stat_tracker.away_win?(@stat_tracker.games.first)
  end

  def test_win_percentage
    assert_equal 0.86, @stat_tracker.win_percentage["6".to_sym]
    assert_equal 0.29, @stat_tracker.win_percentage["3".to_sym]
    assert_equal 0.5, @stat_tracker.win_percentage["15".to_sym]
    assert_equal 0.33, @stat_tracker.win_percentage["4".to_sym]
  end

  def test_home_away_win_percentage_difference
    assert_in_delta 0.33, @stat_tracker.home_away_win_percent_diff["6".to_sym], 0.01
    assert_in_delta 0.67, @stat_tracker.home_away_win_percent_diff["3".to_sym], 0.01
    assert_equal 0.0, @stat_tracker.home_away_win_percent_diff["15".to_sym]
  end
end
