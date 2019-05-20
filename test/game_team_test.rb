require './test/test_helper'
require './lib/stat_tracker'

class GameTeamTest < Minitest::Test
  def setup
    rows = CSV.read('./data/game_teams_stats_abridged.csv', headers: true)
    @game_teams = {}
    rows.each do |row|
      @game_teams["#{row[0]}-#{row[1]}".to_sym] = GameTeam.new(row)
    end
    @first_game_team = rows[0]
    @second_game_team = rows[1]
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_teams["2012030221-3".to_sym]
  end

  def test_attributes
    assert_equal @first_game_team, @game_teams["2012030221-3".to_sym].game_info
    assert_equal @second_game_team, @game_teams["2012030221-6".to_sym].game_info
  end
end
