require './test/test_helper'

class TeamStatsTest < Minitest::Test
  def setup
    @game_path = './data/game_tay.csv'
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
    assert_equal "20122013", @stat_tracker.best_season("6")
  end


  def test_worst_season
    assert_equal "20172018", @stat_tracker.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal 50.0, @stat_tracker.average_win_percentage("6")
    assert_equal 20.0, @stat_tracker.average_win_percentage("3")
  end
end
