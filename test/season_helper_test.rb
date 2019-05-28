require './test/test_helper'

class SeasonHelperTest < MiniTest::Test
  def setup
    @game_path = './data/game_tay.csv'
    @team_path = './data/team_tay.csv'
    @game_teams_path = './data/game_team_stats_dummy_iteration_5.csv'
    @locations = { games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_all_games_by_season
    expected = [["2012030221".to_sym, @stat_tracker.games["2012030221".to_sym]],
                ["2012030222".to_sym, @stat_tracker.games["2012030222".to_sym]],
                ["2012030223".to_sym, @stat_tracker.games["2012030223".to_sym]],
                ["2012030224".to_sym, @stat_tracker.games["2012030224".to_sym]],
                ["2012030225".to_sym, @stat_tracker.games["2012030225".to_sym]]]
    actual = @stat_tracker.all_games_by_season("20122013")
    assert_equal expected, actual
  end

  def test_season_games_by_type
    expected = {'R' => [["2012030221".to_sym, @stat_tracker.games["2012030221".to_sym]],
                        ["2012030222".to_sym, @stat_tracker.games["2012030222".to_sym]],
                        ["2012030223".to_sym, @stat_tracker.games["2012030223".to_sym]]],
                'P' => [["2012030224".to_sym, @stat_tracker.games["2012030224".to_sym]],
                        ["2012030225".to_sym, @stat_tracker.games["2012030225".to_sym]]]}
    actual = @stat_tracker.season_games_by_type("20122013")
    assert_equal expected, actual
  end

  def test_season_game_teams
    expected = @stat_tracker.game_teams.values[0..2]
    actual = @stat_tracker.season_game_teams("20122013",'R')
    assert_equal expected, actual
  end

  def test_season_by_team
    expected = {"3" => [@stat_tracker.game_teams["2012030221".to_sym]["3"],
                        @stat_tracker.game_teams["2012030222".to_sym]["3"],
                        @stat_tracker.game_teams["2012030223".to_sym]["3"]],
                "6" => [@stat_tracker.game_teams["2012030221".to_sym]["6"],
                        @stat_tracker.game_teams["2012030222".to_sym]["6"],
                        @stat_tracker.game_teams["2012030223".to_sym]["6"]]}
    actual = @stat_tracker.season_by_team("20122013",'R')
    assert_equal expected, actual
  end

  def test_wins_by_team
    expected = {"3" => 0.0, "6" => 1.0}
    assert_equal expected, @stat_tracker.wins_by_team("20122013",'R')
  end

  def test_post_reg_difference
    expected = {"3" => 0.5, "6" => -0.5}
    actual = @stat_tracker.post_reg_difference("20122013")
    assert_equal expected, actual
  end

  def test_game_teams_by_season
    expected = [@stat_tracker.game_teams["2012030221".to_sym]["3"],
                @stat_tracker.game_teams["2012030221".to_sym]["6"],
                @stat_tracker.game_teams["2012030222".to_sym]["3"],
                @stat_tracker.game_teams["2012030222".to_sym]["6"],
                @stat_tracker.game_teams["2012030223".to_sym]["3"],
                @stat_tracker.game_teams["2012030223".to_sym]["6"],
                @stat_tracker.game_teams["2012030224".to_sym]["6"],
                @stat_tracker.game_teams["2012030224".to_sym]["3"],
                @stat_tracker.game_teams["2012030225".to_sym]["3"],
                @stat_tracker.game_teams["2012030225".to_sym]["6"]]
    actual = @stat_tracker.game_teams_by_season("20122013")
    assert_equal expected, actual
  end

  def test_game_teams_by_team
    expected = {"3" => [@stat_tracker.game_teams["2012030221".to_sym]["3"],
                @stat_tracker.game_teams["2012030222".to_sym]["3"],
                @stat_tracker.game_teams["2012030223".to_sym]["3"],
                @stat_tracker.game_teams["2012030224".to_sym]["3"],
                @stat_tracker.game_teams["2012030225".to_sym]["3"]],
                "6" => [@stat_tracker.game_teams["2012030221".to_sym]["6"],
                @stat_tracker.game_teams["2012030222".to_sym]["6"],
                @stat_tracker.game_teams["2012030223".to_sym]["6"],
                @stat_tracker.game_teams["2012030224".to_sym]["6"],
                @stat_tracker.game_teams["2012030225".to_sym]["6"]]}
    actual = @stat_tracker.game_teams_by_team("20122013")
    assert_equal expected, actual
  end

  def test_hits_by_team
    expected = {"3" => 179, "6" => 174}
    actual = @stat_tracker.hits_by_team("20122013")
    assert_equal expected, actual
  end
end
