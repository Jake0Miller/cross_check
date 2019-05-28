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
    assert_equal @rows[0], @game_teams[0].game_info
    assert_equal @rows[1], @game_teams[1].game_info
    assert_equal "2012030221", @game_teams[0].game_id
    assert_equal "3", @game_teams[0].team_id
    assert_equal "FALSE", @game_teams[0].won
    assert_equal 44, @game_teams[0].hits
    assert_equal 0, @game_teams[0].power_play_goals
    assert_equal 3, @game_teams[0].power_play_opportunities
  end
end
