require 'csv'
require 'pry'

class Game
  attr_reader :home_team_id, :home_goals, :away_goals, :outcome, :season, :game_row

  def initialize(game_row)
    @game_row = game_row
    @home_team_id = game_row[:home_team_id]
    @home_goals = game_row[:home_goals].to_i
    @away_goals = game_row[:away_goals].to_i 
    @outcome = game_row[:outcome]
    @season = game_row[:season]
  end

end
