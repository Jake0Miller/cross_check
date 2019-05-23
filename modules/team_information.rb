#this module works with team_stats
require "pry"
module TeamInformation

  def find_team(team_id)
    #binding.pry
    @teams[team_id.to_sym]
  end

  def get_team_name_from_id(team_id)
    find_team(team_id).team_name
  end

  def find_games_by_team_id(team_id, games = @games)
    games.find do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
  end
end
