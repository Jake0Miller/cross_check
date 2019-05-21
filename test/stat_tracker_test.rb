require './test/test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './data/game.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_get_teams
    @get_teams = StatTracker.get_teams(@team_path)
    assert_equal 33, @get_teams.size
  end

  def test_get_games
    @get_games = StatTracker.get_games(@game_path)
    assert_equal 7441, @get_games.size
  end

  def test_from_csv
    skip
  end
end
