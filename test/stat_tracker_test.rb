require './test/test_helper'
require './lib/stat_tracker'
require './lib/team'
require 'pry'


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

  def test_get_games
    skip
    expected = ["2012030221","20122013","P",2013-05-16,"3","6",2,3,
          "home win OT","left","TD Garden","/api/v1/venues/null",
          "America/New_York",-4,"EDT"]
    assert_equal expected, @stat_tracker.games[0]
  end

  def test_get_teams
    @get_teams = StatTracker.get_teams(@team_path)
    assert_equal 33, @get_teams.size
  end

  def test_get_game_teams
    skip
    expected = ["2012030221","3","away",FALSE,"OT","John Tortorella",2,35,44,8,
            3,0,44.8,17,7]
    assert_equal expected, @stat_tracker.game_teams[0]
  end

  def test_from_csv
    skip
  end
end
