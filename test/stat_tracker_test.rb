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

  def test_get_game_teams
    assert_equal 14882, StatTracker.get_game_teams(@game_teams_path).size
  end

  def test_from_csv
    skip
  end
end
