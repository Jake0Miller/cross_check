require './test/test_helper'
require './lib/stat_tracker'


class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './data/game.csv'
    @team_path = './data/team_info.csv'
    @game_teams_path = './data/game_teams_stats.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.new(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_from_csv
    expected = @locations
    assert_equal expected, StatTracker.locations
  end
end
