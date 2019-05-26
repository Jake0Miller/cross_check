require './test/test_helper'

class TeamStatsTest < Minitest::Test
  include TeamStatistics
  include TeamInformation

  def setup
    @game_path = './data/game_tay.csv'
    @team_path = './data/team_tay.csv'
    @game_teams_path = './data/game_teams_stats_dummy.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_team_info
    expected = {"team_id" => "14",
                "franchise_id" => "31",
                "short_name" => "Tampa Bay",
                "team_name" => "Lightning",
                "abbreviation" => "TBL",
                "link" => "/api/v1/teams/14"}

    assert_equal expected, @stat_tracker.team_info("14".to_sym)
  end

  def test_best_season
    assert_equal "20122013", @stat_tracker.best_season("3")
    assert_equal "20122013", @stat_tracker.best_season("6")
  end

  def test_worst_season
    assert_equal "20122013", @stat_tracker.worst_season("3")
    assert_equal "20172018", @stat_tracker.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal 0.5, @stat_tracker.average_win_percentage("6")
    assert_equal 0.2, @stat_tracker.average_win_percentage("3")
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

  def test_biggest_team_blowout
    assert_equal 4, @stat_tracker.biggest_team_blowout("6")
    assert_equal 3, @stat_tracker.biggest_team_blowout("14")
    assert_equal 1, @stat_tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 3, @stat_tracker.worst_loss("6")
    assert_equal 3, @stat_tracker.worst_loss("3")
    assert_equal 4, @stat_tracker.worst_loss("14")
  end

  def test_head_to_head
    expected = {"Lightning" => 0.2, "Rangers" => 0.8}
    assert_equal expected, @stat_tracker.head_to_head("6")
  end

  def test_seasonal_summary
    expected = { "20122013" =>{
              regular_season: {win_percentage: 1.0,
                total_goals_scored: 10,
                total_goals_against: 5,
                average_goals_scored: (10.0/3).round(2),
                average_goals_against: (5.0/3).round(2)},
              postseason: {win_percentage: 0.5,
                total_goals_scored: 6,
                total_goals_against: 5,
                average_goals_scored: (6.0/2).round(2),
                average_goals_against: (5.0/2).round(2)}},
            "20172018" => {
              regular_season: {win_percentage: (1.0/3).round(2),
                total_goals_scored: 9,
                total_goals_against: 10,
                average_goals_scored: (9.0/3).round(2),
                average_goals_against: (10.0/3).round(2)},
              postseason: {win_percentage: 0.0,
                total_goals_scored: 4,
                total_goals_against: 7,
                average_goals_scored: (4.0/2).round(2),
                average_goals_against: (7.0/2).round(2)}} }
    assert_equal expected, @stat_tracker.seasonal_summary("6")
  end
end
