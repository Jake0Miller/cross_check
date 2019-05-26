class Game
  attr_reader :game_row, :game_id, :home_team_id, :away_team_id,
              :away_goals, :home_goals, :season, :type

  def initialize(game_row)
    @game_row = game_row
    @game_id = game_row[:game_id]
    @home_team_id = game_row[:home_team_id]
    @away_team_id = game_row[:away_team_id]
    @home_goals = game_row[:home_goals].to_i
    @away_goals = game_row[:away_goals].to_i
    @season = game_row[:season]
    @type = game_row[:type]
  end
end
