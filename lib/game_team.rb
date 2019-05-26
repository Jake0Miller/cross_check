class GameTeam
  attr_reader :game_info, :game_id, :team_id, :won

  def initialize(game_info)
    @game_info = game_info
    @game_id = game_info[:game_id]
    @team_id = game_info[:team_id]
    @won = game_info[:won]
  end
end
