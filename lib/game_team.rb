class GameTeam
  attr_reader :game_info, :game_id, :team_id, :won, :hits,  :shots, :goals,
    :power_play_goals, :head_coach

  def initialize(game_info)
    @game_info = game_info
    @game_id = game_info[:game_id]
    @team_id = game_info[:team_id]
    @won = game_info[:won]
    @hits = game_info[:hits].to_i
    @power_play_goals = game_info[:powerplaygoals].to_i
    @shots = game_info[:shots].to_i
    @goals = game_info[:goals].to_i
    @head_coach = game_info[:head_coach]
  end
end
