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

  def test_get_games
    skip
    expected = ["2012030221","20122013","P",2013-05-16,"3","6",2,3,
          "home win OT","left","TD Garden","/api/v1/venues/null",
          "America/New_York",-4,"EDT"]
    assert_equal expected, @stat_tracker.games[0]
  end

  def test_get_teams
    skip
    expected = ["1","23","New Jersey","Devils","NJD","/api/v1/teams/1"]
    assert_equal expected, @stat_tracker.teams[0]
  end

  def test_get_game_teams
    @game_teams = StatTracker.get_game_teams(@game_teams_path)
    assert_equal 14882, @game_teams.size
  end

  def test_from_csv
    skip
  end
end
