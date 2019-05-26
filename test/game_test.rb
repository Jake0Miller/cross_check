require './test/test_helper'

class GameTest < MiniTest::Test
  def setup
    @rows = CSV.read('./data/game_dummy.csv',
      headers: true, header_converters: CSV::HeaderConverters[:symbol])
    @games = []
    @rows.each do |row|
      @games << Game.new(row)
    end
  end

  def test_it_exists
    assert_instance_of Game, @games.first
  end

  def test_returns_game
    assert_equal @rows.first, @games.first.game_row
  end

  def test_attributes
    assert_equal "2012030221", @games.first.game_id
    assert_equal "20122013", @games.first.season
    assert_equal "6", @games.first.home_team_id
    assert_equal "3", @games.first.away_team_id
    assert_equal 3, @games.first.home_goals
    assert_equal 2, @games.first.away_goals
    assert_equal "P", @games.first.type
  end
end
