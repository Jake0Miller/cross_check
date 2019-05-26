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
  end
end
