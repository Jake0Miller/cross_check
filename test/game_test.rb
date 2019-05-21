require './test/test_helper'

class GameTest < MiniTest::Test

  def setup
    @game_path = './data/game_dummy.csv'

    @rows = CSV.read(@game_path, headers: true)
    @games = {}

    @rows.each do |row|
      @games[row["game_id"]] = Game.new(row)
    end
  end

  def test_it_exists
    assert_instance_of Game, @games["2012030221"]
  end

  def test_returns_game
    # first row stored in games.first
    assert_equal @rows.first, @games["2012030221"].game_row
  end
end
