require './test/test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './data/game_dummy.csv'
    @team_path = './data/team_dummy.csv'
    @game_teams_path = './data/game_teams_stats_dummy.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_counts_of_teams
    assert_equal 6, @stat_tracker.teams.size
  end

  def test_total_goals
    assert_equal 16, @stat_tracker.total_goals["6".to_sym]
    assert_equal 10, @stat_tracker.total_goals["3".to_sym]
  end

  def test_total_games
    assert_equal 5, @stat_tracker.total_games["6".to_sym]
    assert_equal 5, @stat_tracker.total_games["3".to_sym]
  end

  def test_average_score
    assert_equal 3.2, @stat_tracker.average_score["6".to_sym]
    assert_equal 2.0, @stat_tracker.average_score["3".to_sym]
  end

  def test_best_offense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Rangers", @stat_tracker.worst_offense
  end

  def test_total_goals_allowed
    assert_equal 10, @stat_tracker.total_goals_allowed["6".to_sym]
    assert_equal 16, @stat_tracker.total_goals_allowed["3".to_sym]
  end

  def test_average_goals_allowed
    assert_equal 2.0, @stat_tracker.average_goals_allowed["6".to_sym]
    assert_equal 3.2, @stat_tracker.average_goals_allowed["3".to_sym]
  end

  def test_best_defense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_defense
    assert_equal "Rangers", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "Bruins", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "Rangers", @stat_tracker.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Bruins", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal "Rangers", @stat_tracker.lowest_scoring_home_team
  end

  def test_total_wins
    assert_equal 4, @stat_tracker.total_wins["6".to_sym]
    assert_equal 1, @stat_tracker.total_wins["3".to_sym]
  end

  def test_winningest_team
    assert_equal "Bruins", @stat_tracker.winningest_team
  end

  def test_win_percentage
    #assert_equal 0.00, @stat_tracker.win_percentage(false, true)["3".to_sym]
    assert_equal 100.00, @stat_tracker.win_percentage(true, false)["6".to_sym]
    assert_equal 50.00, @stat_tracker.win_percentage(false, true)["6".to_sym]
    assert_equal 50.00, @stat_tracker.win_percentage(true, false)["3".to_sym]
  end

  def test_away_win_percentage
    skip
  end

  def test_best_fans
    skip
  end

  def test_worst_fans
    skip
  end
end
