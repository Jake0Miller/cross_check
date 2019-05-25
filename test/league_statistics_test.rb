require './test/test_helper'

class LeagueStatisticsTest < Minitest::Test
  def setup
    @game_path = './data/game_jake.csv'
    @team_path = './data/team_jake.csv'
    @game_teams_path = './data/game_teams_stats_dummy.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_counts_of_teams
    assert_equal 5, @stat_tracker.teams.length
  end

  def test_best_offense
    assert_equal "Bruins", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Flyers", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Bruins", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Flyers", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "Capitals", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "Flyers", @stat_tracker.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Penguins", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal "Flyers", @stat_tracker.lowest_scoring_home_team
  end

  def test_winningest_team
    assert_equal "Bruins", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Rangers", @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Flyers"], @stat_tracker.worst_fans
  end
end
