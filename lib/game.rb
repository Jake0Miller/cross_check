require 'csv'
require 'pry'

class Game
  attr_reader :game_row

  def initialize(game_row)
    @game_row = game_row
  end
end
