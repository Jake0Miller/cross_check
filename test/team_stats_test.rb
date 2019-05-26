require './test/test_helper'
require './modules/team_information'
require './modules/team_statistics'
require 'pry'

class TeamStatsTest < Minitest::Test
  include TeamStatistics
  include TeamInformation

  def setup
    @game_path = './data/game_dummy.csv'
    @team_path = './data/team_dummy.csv'
    @game_teams_path = './data/game_teams_stats_dummy.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)

  end

  def test_team_info
    expected = {"team_id" => "1",
                "franchiseId" => "23",
                "shortName" => "New Jersey",
                "teamName" => "Devils",
                "abbreviation" => "NJD",
                "link" => "/api/v1/teams/1"}

    assert_equal expected, @stat_tracker.team_info("1".to_sym)
  end

  def test_best_season
    assert_equal "20122013", @stat_tracker.best_season("3")
    assert_equal "20122015", @stat_tracker.best_season("6")
  end


  def test_worst_season
    assert_equal "20122015", @stat_tracker.worst_season("3")
    assert_equal "20122013", @stat_tracker.worst_season("6")
  end

  def test_average_win_percentage_for_a_team
    assert_equal 80.0, @stat_tracker.average_win_percentage("6")
    assert_equal 20.0, @stat_tracker.average_win_percentage("3")
  end

  def test_most_goals_scored
    assert_equal 6, @stat_tracker.most_goals_scored("6")
    assert_equal 4, @stat_tracker.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    assert_equal 1, @stat_tracker.fewest_goals_scored("6")
    assert_equal 1, @stat_tracker.fewest_goals_scored("3")
  end

  def test_favorite_opponent
    assert_equal "Rangers", @stat_tracker.favorite_opponent("6")
  end

  def test_rival
    assert_equal "Lightning", @stat_tracker.rival("6")
  end

  def test_head_to_head
    expected = {"Lightning" => 20.0, "Rangers" => 80.0}
    assert_equal expected, @stat_tracker.head_to_head("6")
  end

  def test_worst_loss
    assert_equal 3, @stat_tracker.worst_loss("6")
  end
end
