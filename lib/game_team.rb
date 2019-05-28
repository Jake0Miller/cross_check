class GameTeam
  attr_reader :game_info, :game_id, :team_id, :won, :hits,
    :power_play_goals, :power_play_opportunities, :head_coach

  def initialize(game_info)
    @game_info = game_info
    @game_id = game_info[:game_id]
    @team_id = game_info[:team_id]
    @won = game_info[:won]
    @hits = game_info[:hits].to_i
    @power_play_goals = game_info[:powerplaygoals].to_i
    @power_play_opportunities = game_info[:powerplayopportunities].to_i
    @head_coach = game_info[:head_coach]
  end
end
