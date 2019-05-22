require './test/test_helper'

class GameTest < MiniTest::Test

  def setup
    @game_path = './data/game_dummy.csv'
    @rows = CSV.read(@game_path, headers: true, header_converters: CSV::HeaderConverters[:symbol])
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
end
