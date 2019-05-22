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

  def test_best_offense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Rangers", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_defense
    assert_equal "Rangers", @stat_tracker.worst_offense
  end
end
