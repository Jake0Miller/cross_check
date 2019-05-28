require './test/test_helper'

class GameTeamTest < Minitest::Test
  def setup
    @rows = CSV.read('./data/game_teams_stats_dummy.csv',
      headers: true, header_converters: CSV::HeaderConverters[:symbol])
    @game_teams = []
    @rows.each do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_teams.first
  end

  def test_attributes
    expected = stub(game_id: "2012030221", team_id: "3",
                    won: "FALSE", hits: 44,
                    power_play_goals: 0, power_play_opportunities: 3)
    assert_equal @rows[0], @game_teams[0].game_info
    assert_equal @rows[1], @game_teams[1].game_info
    assert_equal expected.game_id, @game_teams[0].game_id
    assert_equal expected.team_id, @game_teams[0].team_id
    assert_equal expected.won, @game_teams[0].won
    assert_equal expected.hits, @game_teams[0].hits
    assert_equal expected.power_play_goals, @game_teams[0].power_play_goals
    assert_equal expected.power_play_opportunities, @game_teams[0].power_play_opportunities
  end
end
