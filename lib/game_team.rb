class GameTeam
  attr_reader :game_info, :game_id, :team_id, :won, :shots, :goals, :head_coach

  def initialize(game_info)
    @game_info = game_info
    @game_id = game_info[:game_id]
    @team_id = game_info[:team_id]
    @won = game_info[:won]
    @shots = game_info[:shots]
    @goals = game_info[:goals]
    @head_coach = game_info[:head_coach]
  end
end
