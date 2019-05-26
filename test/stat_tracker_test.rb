require './test/test_helper'
require 'pry'

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

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_get_games
    assert_equal 5, StatTracker.get_games(@game_path).length
  end

  def test_get_game_teams
    assert_equal 2, StatTracker.get_game_teams(@game_teams_path).size
  end

  def test_get_teams
    assert_equal 6, StatTracker.get_teams(@team_path).length
  end

  def test_games_are_game_objects
    @stat_tracker.games.each do |game|
      assert_instance_of Game, game
    end
  end

  def test_game_teams_are_game_objects
    @stat_tracker.game_teams.each do |game_team|
      assert_instance_of GameTeam, game_team
    end
  end

  def test_teams_are_game_objects
    @stat_tracker.teams.each do |team|
      assert_instance_of Team, team[1]
    end
  end

  def test_from_csv
    assert_equal 5, @stat_tracker.games.size
    assert_equal 6, @stat_tracker.teams.size
    assert_equal 2, @stat_tracker.game_teams.size
  end
end
